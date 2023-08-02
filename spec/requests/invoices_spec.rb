# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:invoices) { create_list(:invoice, 5, user: user) }
  let!(:invoice_id) { invoices.first.id }

  describe 'GET /api/v1/invoices' do
    before { get '/api/v1/invoices' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns invoices' do
      expect(json.size).to eq(5)
    end
  end

  describe 'DELETE /invoices/:id' do
    before { delete "/api/v1/invoices/#{invoice_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
