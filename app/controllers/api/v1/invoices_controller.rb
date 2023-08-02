# frozen_string_literal: true

module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_invoice, only: %i[show update destroy]

      def index
        invoices = paginate current_user.invoices, per_page: 10
        render json: {
          status: { code: 200, message: 'Show list invoices' },
          data: InvoiceSerializer.new(invoices).serializable_hash[:data],
        }, status: :ok
      end

      def show
        if @invoice
          render json: {
            status: { code: 200, message: 'Show Invoice' },
            data: InvoiceSerializer.new(@invoice).serializable_hash[:data][:attributes],
          }, status: :ok
        else
          render json: { message: @invoice.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
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
        if @invoice.update(invoice_params)
          render json: {
            status: { code: 200, message: 'Invoice updated' },
            data: InvoiceSerializer.new(@invoice).serializable_hash[:data][:attributes],
          }, status: :ok
        else
          render json: { message: @invoice.errors.full_messages.to_sentence }, status: :unprocessable_entity
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
          invoice_items_attributes: %i[name qty unit_price]
        )
      end

      def set_invoice
        @invoice = current_user.invoices.find(params[:id])
      end
    end
  end
end
