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

class FileResourceSerializer < ActiveModel::Serializer # :nodoc:
  type :files

  attributes :id, :name
end
