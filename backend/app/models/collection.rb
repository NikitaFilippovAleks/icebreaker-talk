# frozen_string_literal: true

# Collection model
class Collection < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true, uniqueness: true
  validates :description, presence: true
end

# == Schema Information
#
# Table name: collections
#
#  id          :uuid             not null, primary key
#  color       :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
