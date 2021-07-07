# frozen_string_literal: true

EQUIPMENTS_NUMBER = 6

EQUIPMENTS_NUMBER.times do |j|
  Equipment.create!(name: Faker::Commerce.product_name,
                    kind: Faker::Commerce.material,
                    sn: Faker::IDNumber.valid)
end
