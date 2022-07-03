# frozen_string_literal: true

FactoryBot.define do
  factory :picture do
    name { Faker::Name.name }
  end
end
