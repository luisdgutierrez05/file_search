# frozen_string_literal: true

FactoryBot.define do
  factory :file_resource, class: FileResource do
    sequence(:name, '1') { |n| 'File' + n }
    tags { [] }
  end
end
