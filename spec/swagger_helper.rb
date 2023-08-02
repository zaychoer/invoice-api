# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'INVOICE API V1',
        version: 'v1',
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: '127.0.0.1:3000',
            },
          },
        },
      ],
      components: {
        schemas: {
          pagination: {
            type: :object,
            properties: {
              recordCount: { type: :integer },
              pageCount: { type: :integer },
              currentPage: { type: :integer },
              pageSize: { type: :integer },
            },
            required: %w[recordCount pageCount currentPage pageSize],
          },
          error_response: {
            type: :object,
            properties: {
              errors: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    type: { type: :string,
                            description: 'type of error' },
                    message: { type: :string, nullable: true },
                  },
                  required: %w[type message],
                },
              },
              status: { type: :integer },
            },
            required: %w[errors status],
          },
          invoice: {
            type: :object,
            properties: {
              id: { type: :integer },
              invoice_number: { type: :string },
              due_date: { type: :string },
              invoice_items: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    invoice_id: { type: :integer },
                    qty: { type: :integer },
                    unit_price: { type: :integer },
                  },
                },
              },
              createdAt: { type: :string },
              updatedAt: { type: :string },
            },
          },
          securitySchemes: {
            bearerAuth: {
              type: 'http',
              scheme: 'bearer',
              bearerFormat: 'JWT',
            },
          },
        },
      },
      security: [{
        bearerAuth: [],
      }],
    },
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
