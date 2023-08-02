# frozen_string_literal: true

class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  validates :name, presence: true
  validates :qty, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
    qty * unit_price
  end
end
