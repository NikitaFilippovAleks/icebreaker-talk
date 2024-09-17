# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    name { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    color { Faker::Color.hex_color }

    after(:create) do |collection|
      create_list(:question, 3, collection:)
    end
  end
end

# == Schema Information
#
# Table name: collections
#
#  id          :bigint           not null, primary key
#  color       :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
