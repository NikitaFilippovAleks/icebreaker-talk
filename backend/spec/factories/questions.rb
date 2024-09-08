# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    text { Faker::Lorem.paragraph }

    # trait :with_base_associations do
    #   collection_id { create(:collection).id }
    # end
  end
end

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
