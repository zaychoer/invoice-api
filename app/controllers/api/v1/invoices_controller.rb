# frozen_string_literal: true

class Api::V1::InvoicesController < ApplicationController
  before_action :set_invoice, only: :destroy

  def index
    invoices = paginate Invoice.all, per_page: 10
    render json: {
      status: { code: 200, message: 'Show list invoices' },
      data: InvoiceSerializer.new(invoices).serializable_hash[:data],
    }, status: :ok
  end

  def create
    invoice = current_user.invoices.build(invoice_params)
    if invoice.save
      render json: {
        status: { code: 201, message: 'Invoice created' },
        data: InvoiceSerializer.new(invoice).serializable_hash[:data][:attributes],
      }, status: :created
    else
      render json: { message: invoice.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    invoice = Invoices.find(params[:id])
    if invoice.update(invoice_params)
      render json: {
        status: { code: 200, message: 'Invoice updated' },
        data: InvoiceSerializer.new(invoice).serializable_hash[:data][:attributes],
      }, status: :ok
    else
      render json: { message: invoice.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy
    head :no_content
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :invoice_number,
      :due_date,
      invoice_items_attributes: %i[id name qty unit_price]
    )
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
end
