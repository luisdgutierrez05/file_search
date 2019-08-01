# frozen_string_literal: true

class FilterTagsService # :nodoc:
  # Attributes
  attr_reader :query_params, :page, :files

  # Initializer
  def initialize(query_params, page)
    @query_params = query_params
    @page = page.to_i
  end

  # Main method
  # Filter files by tags and page number.
  # @returns [Hash] list of files.
  def perform
    valid_page_number?

    where_sql = 'tags @> ARRAY[?]'
    @files = FileResource.where(where_sql, included_tags)
                         .where.not(where_sql, excluded_tags)
                         .paginate(page: page)

    filter_results
  end

  private

  # Checks if page param is an integer value.
  # @returns [Boolean] true/false
  def valid_page_number?
    raise_invalid_page_number_error if page <= 0
  end

  # Gets all positive tags
  # @returns [Array] list of positive tags.
  def included_tags
    query_params&.scan(/[\+]([a-zA-Z\d]+\w)(?=\s|\b)/)&.flatten
  end

  # Gets all negative tags
  # @returns [Array] list of negative tags.
  def excluded_tags
    query_params&.scan(/[\-]([a-zA-Z\d]+\w)(?=\s|\b)/)&.flatten
  end

  # Gets the related tags of the current search.
  # @returns [Hash] related tags information.
  def related_tags
    tag_list = files&.map(&:tags)&.flatten - included_tags

    return [] if tag_list.empty?

    tag_list.group_by(&:itself).map do |key, value|
      { tag: key, file_count: value.length }
    end
  end

  # Generates a hash with meta response parameters.
  # @returns [Hash] meta response parameters.
  def meta
    {
      total_records: files.count,
      related_tags: related_tags
    }
  end

  # Generates a hash with filter results.
  # @returns [Hash] filter results.
  def filter_results
    {
      files: files,
      meta: meta
    }
  end

  # Raises an exception if page number is invalid.
  # @return [CustomExceptions::InvalidRequestError] invalid request error.
  def raise_invalid_page_number_error
    message = I18n.t('services.filter_tags.exceptions.invalid_page_number')
    raise ::CustomExceptions::InvalidRequestError, message
  end
end
