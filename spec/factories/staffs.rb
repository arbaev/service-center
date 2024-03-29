# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :invalid do
      password { nil }
    end
  end
end
