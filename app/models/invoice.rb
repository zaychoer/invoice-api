# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_items, dependent: :destroy

  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  validates :invoice_number, presence: true, uniqueness: true
  validates :due_date, presence: true

  before_save :calculate_total

  private

  def calculate_total
    self.total = invoice_items.sum(&:subtotal)
  end
end
