FactoryBot.define do
  factory :org_type do
    name { %w[ИП ООО ПАО АО НКО].sample }
  end
end
