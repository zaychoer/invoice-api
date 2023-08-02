# frozen_string_literal: true

class ChangeTotalToDecimalInInvoices < ActiveRecord::Migration[7.0]
  def up
    change_column :invoices, :total, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end

  def down
    change_column :invoices, :total, :integer
  end
end
