require 'swagger_helper'

RSpec.describe 'api/v1/invoices', type: :request do
  path '/api/v1/invoices' do
    get('list invoices') do
      tags 'Invoices'
      produces 'application/json'
      consumes 'application/json'
      parameter invoice_number: :query,
                in: :query,
                type: :string,
                description: 'optional invoice_number to search',
                required: false
      parameter name: 'page[size]',
                in: :query,
                type: :integer,
                description: 'number of invoices per page',
                required: false
      parameter name: 'page[number]',
                in: :query,
                type: :integer,
                description: 'page number',
                required: false
      response(200, 'successful') do
        let(:Authorization) do
          valid_basic_auth_token
        end
        let(:query) { invoice.invoice_number }
        let(:page) { { number: 1, size: 1 } }
        examples
        schema type: :object,
               properties: {
                 meta: {
                   '$ref' => '#/components/schemas/pagination',
                 },
                 data: {
                   type: :object,
                   properties: {
                     invoices: {
                       type: :array,
                       items: { '$ref' => '#/components/schemas/invoice' },
                     },
                   },
                   required: ['invoices'],
                 },
               }
        run_test! do # assert like you do in controller tests
          expect(parsed_obj.data.invoices.size).to eq(1)
          meta = parsed_obj.meta
          expect(meta.recordCount).to eq(1)
          expect(meta.pageCount).to eq(1)
          expect(meta.currentPage).to eq(1)
          expect(meta.pageSize).to eq(15)
          invoice = parsed_obj.data.invoices.first
          assert_invoice(invoice) # removed for brevity
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end

    post('create invoice') do
      response(200, 'successful') do
        tags 'Invoices'
        consumes 'application/json'
        parameter name: :invoice, in: :body, schema: {
          type: :object,
          properties: {
            invoice_number: { type: :string },
            due_date: { type: :string },
            invoice_items_attributes: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  name: { type: :string },
                  qty: { type: :number },
                  unit_price: { type: :number },
                },
              },
            },
          },
          required: %w[invoice_number due_date],
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/invoices/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show invoice') do
      tags 'Invoices'
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end

    patch('update invoice') do
      response(200, 'successful') do
        tags 'Invoices'
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end

    put('update invoice') do
      response(200, 'successful') do
        tags 'Invoices'
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end

    delete('delete invoice') do
      response(200, 'successful') do
        tags 'Invoices'
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true),
            },
          }
        end
        run_test!
      end
    end
  end
end
