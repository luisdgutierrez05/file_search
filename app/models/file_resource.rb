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

class FileResource < ApplicationRecord # :nodoc:
  # Set default per page value.
  self.per_page = 10

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: true
  validates_with FileResourceValidator
end
