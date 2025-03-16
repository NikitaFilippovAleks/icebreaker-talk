FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  refresh_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
