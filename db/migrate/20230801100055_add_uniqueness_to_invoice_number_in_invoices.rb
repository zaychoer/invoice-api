# frozen_string_literal: true

class AddUniquenessToInvoiceNumberInInvoices < ActiveRecord::Migration[7.0]
  def change
    add_index :invoices, :invoice_number, unique: true
  end
end
