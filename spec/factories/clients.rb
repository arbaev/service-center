# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
