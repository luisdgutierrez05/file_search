# frozen_string_literal: true

# == Schema Information
#
# Table name: file_resources
#
#  id         :uuid             not null, primary key
#  name       :string
#  tags       :text             default([]), is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe FileResource, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe 'Custom validations' do
    context 'validates empty tags' do
      context 'when there are no tags' do
        let(:file_1) { FactoryBot.build(:file_resource, tags: []) }

        it 'returns an invalid record message' do
          validation_result = file_1.valid?
          file_error = file_1.errors.full_messages.join('')
          error_message = I18n.t('models.file_resource.errors.tags.empty_array')

          expect(validation_result).to be_falsey
          expect(file_error).to eq(error_message)
        end
      end

      context 'when there are tags' do
        let(:file_2) { FactoryBot.build(:file_resource, tags: ['NewTag']) }

        it 'returns no errors' do
          validation_result = file_2.valid?
          file_error = file_2.errors.full_messages

          expect(validation_result).to be_truthy
          expect(file_error).to be_empty
        end
      end
    end

    context 'validates duplicate tags' do
      context 'when there are duplicated tags' do
        let(:file_1) { FactoryBot.build(:file_resource, tags: %w[Tag1 tag1]) }

        it 'returns an invalid record message' do
          validation_result = file_1.valid?
          file_error = file_1.errors.full_messages.join('')
          error_message = I18n.t('models.file_resource.errors.tags.duplicated')

          expect(validation_result).to be_falsey
          expect(file_error).to eq(error_message)
        end
      end

      context 'when there are no duplicate tags' do
        let(:file_2) { FactoryBot.build(:file_resource, tags: %w[Tag1 Tag2]) }

        it 'returns no errors' do
          validation_result = file_2.valid?
          file_error = file_2.errors.full_messages

          expect(validation_result).to be_truthy
          expect(file_error).to be_empty
        end
      end
    end

    context 'validates tag names format' do
      context 'when tag names has invalid format' do
        let(:file_1) { FactoryBot.build(:file_resource, tags: ['+Tag1']) }

        it 'returns an invalid record message' do
          validation_result = file_1.valid?
          file_error = file_1.errors.full_messages.join('')
          error_message = 'Invalid tag name for +Tag1, should not include +, - or space characters.'

          expect(validation_result).to be_falsey
          expect(file_error).to eq(error_message)
        end
      end

      context 'when tag names has valid format' do
        let(:file_2) { FactoryBot.build(:file_resource, tags: %w[TagValid tag3 TagN6]) }

        it 'returns no errors' do
          validation_result = file_2.valid?
          file_error = file_2.errors.full_messages

          expect(validation_result).to be_truthy
          expect(file_error).to be_empty
        end
      end
    end
  end
end
