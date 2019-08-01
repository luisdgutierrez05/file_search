# frozen_string_literal: true

# Class to validate tags attribute into a FileResource instance.
class FileResourceValidator < ActiveModel::Validator
  # Constants
  TAG_NAME_PATTERN = Regexp.new('^[^\s+-]+$').freeze

  # Validates tags information.
  def validate(record)
    @record = record

    empty_tags?
    duplicate_tags?
    valid_tag_names?
  end

  private

  # Validates if array of tags is empty.
  # @returns [Boolean] true/false
  def empty_tags?
    return false if @record.tags&.any?

    error_message = I18n.t('models.file_resource.errors.tags.empty_array')
    add_error_record(error_message)
  end

  # Gets a list of unique tags
  # @returns [Array] list of tags
  def unique_tags
    @record.tags&.map(&:downcase)&.uniq
  end

  # Validates if some of the tags are duplicated.
  # @returns [Boolean] true/false
  def duplicate_tags?
    return false if @record.tags&.length == unique_tags&.length

    error_message = I18n.t('models.file_resource.errors.tags.duplicated')
    add_error_record(error_message)
  end

  # Validates each tag name format.
  # @returns [Boolean] true/false
  def valid_tag_names?
    @record.tags&.each do |tag|
      next if TAG_NAME_PATTERN.match?(tag)

      error_message = invalid_name_message(tag)
      add_error_record(error_message)
      return false
    end
  end

  # Adds error to record instance.
  # @params error_message [String] Error message.
  # @returns [Boolean] true/false
  def add_error_record(error_message)
    return if error_message.nil?

    @record.errors[:base] << error_message
  end

  # Generates an error message fo an invalid tag name format
  def invalid_name_message(name)
    I18n.t('models.file_resource.errors.tags.invalid_format', tag_name: name)
  end
end
