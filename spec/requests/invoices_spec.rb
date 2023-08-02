# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:invoices) { create_list(:invoice, 5, user: user) }
  let!(:invoice) { invoices.first }
  let(:valid_invoice_params) do
    {
      invoice: {
        invoice_number: 'INV001',
        due_date: '2023-08-15',
        invoice_items_attributes: [
          { name: 'Item 1', qty: 2, unit_price: 50 },
          { name: 'Item 2', qty: 3, unit_price: 30 },
        ],
      },
    }
  end

  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  describe 'POST /api/v1/invoices' do
    context 'when user is authenticated' do
      before do
        post '/api/v1/invoices',
             params: valid_invoice_params.to_json,
             headers: @auth_headers
      end

      it 'creates a new invoice' do
        expect(response).to have_http_status(:created)
      end

      it 'returns total price' do
        expect(json['total'].to_f).to eq(190.0)
      end
    end

    context 'when user is not authenticated' do
      before { post '/api/v1/invoices', params: valid_invoice_params }

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/invoices' do
    before { get '/api/v1/invoices', headers: @auth_headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns invoices' do
      expect(json.size).to eq(5)
    end
  end

  describe 'GET /api/v1/invoices/:id' do
    before { get "/api/v1/invoices/#{invoice.id}", headers: @auth_headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns same invoice number' do
      expect(json['invoice_number']).to eq(invoice.invoice_number)
    end
  end

  describe 'PUT /api/v1/invoices/:id' do
    context 'when user is authenticated' do
      before do
        put "/api/v1/invoices/#{invoice.id}",
            params: valid_invoice_params.to_json,
            headers: @auth_headers
      end

      it 'updates the invoice' do
        expect(response).to have_http_status(:ok)
        expect(json['invoice_number']).to eq(valid_invoice_params[:invoice][:invoice_number])
      end
    end

    context 'when user is not authenticated' do
      before { put "/api/v1/invoices/#{invoice.id}", params: valid_invoice_params }

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /invoices/:id' do
    before { delete "/api/v1/invoices/#{invoice.id}", headers: @auth_headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
