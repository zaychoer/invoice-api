# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    association :user
    invoice_number { Faker::Invoice.reference }
    due_date { Faker::Date.forward(days: 30) }

    transient do
      invoice_items_count { 2 }
    end

    after(:build) do |invoice, evaluator|
      invoice.invoice_items = build_list(
        :invoice_item,
        evaluator.invoice_items_count,
        invoice: invoice
      )
    end
  end
end
