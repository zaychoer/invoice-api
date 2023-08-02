# frozen_string_literal: true

class InvoiceSerializer
  include JSONAPI::Serializer
  attributes :id,
             :invoice_number,
             :due_date,
             :total,
             :created_at,
             :updated_at,
             :invoice_items
end
