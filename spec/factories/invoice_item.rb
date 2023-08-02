# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    association :invoice
    name { Faker::Commerce.product_name }
    qty { Faker::Number.between(from: 1, to: 10) }
    unit_price { Faker::Commerce.price }
  end
end
