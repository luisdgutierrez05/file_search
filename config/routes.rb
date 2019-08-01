# frozen_string_literal: true

# == Route Map
#
#       Prefix Verb URI Pattern                                     Controller#Action
#              GET  /api/v1/files/:tag_search_query/:page(.:format) api/v1/files#index {:format=>"json"}
# api_v1_files POST /api/v1/files(.:format)                         api/v1/files#create {:format=>"json"}

Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :files, only: %i[create] do
        collection do
          get ':tag_search_query/:page', to: 'files#index'
        end
      end
    end
  end
end
