# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:invoices) }

  it 'has a valid factory' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end
end
