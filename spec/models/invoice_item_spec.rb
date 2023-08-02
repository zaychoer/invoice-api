# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  # Association test
  it { should belong_to(:invoice) }
  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:qty) }
  it { should validate_numericality_of(:qty).only_integer }
  it do
    should validate_numericality_of(:qty)
      .is_greater_than(0)
  end

  it 'has a valid factory' do
    invoice_item = FactoryBot.build(:invoice_item)
    expect(invoice_item).to be_valid
  end
end
