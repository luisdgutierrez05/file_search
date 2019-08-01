# frozen_string_literal: true

ActiveModel::Serializer.config.adapter = :json_api

# This is to remove the default links response
class NonPaginatedCollectionSerializer < ActiveModel::Serializer::CollectionSerializer
  def paginated?
    false
  end
end

ActiveModel::Serializer.config.collection_serializer = NonPaginatedCollectionSerializer
