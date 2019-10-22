FactoryBot.define do
  factory :equipment do
    name { Faker::Commerce.product_name }
    kind { Faker::Commerce.material }
    sn { Faker::IDNumber.valid }
  end
end
