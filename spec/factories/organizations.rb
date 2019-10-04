FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    inn { Faker::Number.number(digits: 10) }
    ogrn { Faker::Number.number(digits: 13) }
    association :org_type
  end
end
