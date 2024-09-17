# frozen_string_literal: true

# Question model
class Question < ApplicationRecord
  belongs_to :collection

  validates :text, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: questions
#
#  id            :uuid             not null, primary key
#  text          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  collection_id :uuid             not null
#
# Indexes
#
#  index_questions_on_collection_id  (collection_id)
#
# Foreign Keys
#
#  fk_rails_...  (collection_id => collections.id)
#
