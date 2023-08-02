# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    include RackSessionsFix
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render_success_response(resource)
      else
        render_error_response(resource)
      end
    end

    def render_success_response(resource)
      render json: {
        status: {
          code: 200,
          message: 'Signed up successfully.',
        },
        data: serialized_user_attributes(resource),
      }, status: :ok
    end

    def render_error_response(resource)
      render json: {
        status: {
          code: 422,
          message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}",
        },
      }, status: :unprocessable_entity
    end

    def serialized_user_attributes(resource)
      UserSerializer.new(resource).serializable_hash[:data][:attributes]
    end
  end
end
