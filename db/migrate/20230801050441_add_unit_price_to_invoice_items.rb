class AddUnitPriceToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_items, :unit_price, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
