# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    fullname { Faker::Name.name }
    phone do
      # get rid of american style numbers like '1-195-646-2015'
      cellphone = Faker::PhoneNumber.cell_phone
      cellphone[0..1] == '1-' ? cellphone[2..] : cellphone
    end
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }

    trait :invalid do
      fullname { nil }
    end
  end
end
