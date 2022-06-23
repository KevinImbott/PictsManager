# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    name { Faker::Name.name }
  end
end
