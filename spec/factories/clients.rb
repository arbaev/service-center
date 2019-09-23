# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    fullname { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :invalid do
      fullname { nil }
    end
  end
end
