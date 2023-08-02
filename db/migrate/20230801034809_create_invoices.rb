# frozen_string_literal: true

class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :invoice_number
      t.date :due_date
      t.decimal :total

      t.timestamps
    end
  end
end
