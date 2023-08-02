# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  # Association test
  it { should belong_to(:user) }
  it { should have_many(:invoice_items) }

  # # Validation tests
  it { should validate_presence_of(:invoice_number) }
  it { should validate_presence_of(:due_date) }

  it 'has a valid factory' do
    invoice = FactoryBot.build(:invoice)
    expect(invoice).to be_valid
  end
end
