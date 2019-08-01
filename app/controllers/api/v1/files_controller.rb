# frozen_string_literal: true

module Api
  module V1
    class FilesController < ApplicationController # :nodoc:
      # GET /files/:tag_search_query/:page
      # Displays all files filtered by tag and page
      # @returns [Hash] list of files.
      def index
        results = FilterTagsService.new(query_param, page_param).perform
        json_response(results[:files], :ok, results[:meta])
      end

      # POST /files
      # Creates a new file.
      # @returns [Hash] file information created.
      def create
        file = FileResource.create!(file_params)
        json_response(file, :created)
      end

      private

      # Gets file attributes from request parameters.
      # @return [Hash] the file parameters.
      def file_params
        params.require(:data)
              .require(:attributes)
              .permit(:name, tags: [])
      end

      # Gets tag search query attribute from url request.
      # @return [String] tags to search.
      def query_param
        params&.dig(:tag_search_query)
      end

      # Gets page attribute from url request.
      # @return [String] page number.
      def page_param
        params&.dig(:page)
      end
    end
  end
end
