# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Files API', type: :request do
  let(:headers) do
    {
      'Content-Type': 'application/vnd.api+json'
    }
  end

  describe 'POST /api/v1/files' do
    context 'when the request is valid' do
      let(:valid_attributes) do
        {
          data: {
            attributes: {
              name: 'File A',
              tags: ['TagA']
            }
          }
        }
      end

      it 'Creates a new file' do
        post '/api/v1/files', params: valid_attributes.to_json, headers: headers

        expect(response).to have_http_status(201)
        expect(json.dig('data', 'attributes', 'name')).to eq('File A')
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) do
        {
          data: {
            attributes: {
              name: 'File B'
            }
          }
        }
      end

      it 'returns a validation failure message' do
        post '/api/v1/files', params: invalid_attributes.to_json, headers: headers

        expect(response).to have_http_status(422)
        expect(response.body).to match(/Validation failed: There is no tags./)
      end
    end

    context 'when the request has invalid params' do
      let(:invalid_attributes) do
        {
          data: {}
        }
      end

      it 'returns a bad request message' do
        post '/api/v1/files', params: invalid_attributes.to_json, headers: headers

        expect(response.body).to match(/param is missing or the value is empty: data/)
      end
    end
  end

  describe 'GET /api/v1/files/:tag_search_query/:page' do
    context 'when the request is valid' do
      let(:file_samples) do
        {
          'File1' => %w[Tag1 Tag2 Tag3 Tag5],
          'File2' => %w[Tag2],
          'File3' => %w[Tag2 Tag3 Tag5],
          'File4' => %w[Tag2 Tag3 Tag4 Tag5],
          'File5' => %w[Tag3 Tag4]
        }
      end

      before do
        file_samples.each do |name,tags|
          FactoryBot.create(:file_resource, name: name, tags: tags)
        end
      end

      it 'Gets a list of files filtered by tags: [+Tag2 +Tag3 -Tag4]' do
        get '/api/v1/files/%2BTag2%20%2BTag3%20-Tag4/1', headers: headers

        data_info = json.dig('data')

        expect(response).to have_http_status(200)

        expect(data_info.count).to eq(2)
        expect(data_info[0]['attributes']['name']).to eq('File1')
        expect(data_info[1]['attributes']['name']).to eq('File3')

        expect(json.dig('meta', 'total-records')).to eq(2)

        expect(json.dig('meta', 'related-tags').count).to eq(2)
        expect(json.dig('meta', 'related-tags')[0]['tag']).to eq('Tag1')
        expect(json.dig('meta', 'related-tags')[1]['tag']).to eq('Tag5')
      end
    end

    context 'when the request is invalid' do
      it 'returns a invalid request error' do
        get '/api/v1/files/%2BTag2%20%2BTag3%20-Tag4/invalid', headers: headers

        error_message = I18n.t('services.filter_tags.exceptions.invalid_page_number')

        expect(json['message']).to eq(error_message)
      end
    end
  end
end
