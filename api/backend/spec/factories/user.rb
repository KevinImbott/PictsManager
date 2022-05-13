# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    pseudo { Faker::Name.name }
  end
end
