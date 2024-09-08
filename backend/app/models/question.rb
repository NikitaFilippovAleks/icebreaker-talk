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
#  id         :bigint           not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
