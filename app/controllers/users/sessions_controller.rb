# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include RackSessionsFix
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      render json: {
        status: {
          code: 200, message: 'Logged in successfully'
        },
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        },
      }, status: :ok
    end

    def respond_to_on_destroy
      return if request.headers['Authorization'].blank?

      jwt_payload = decoded_jwt_payload
      current_user = find_current_user(jwt_payload['sub'])

      return render_unauthorized unless current_user

      render_success_message(current_user)
    end

    def decoded_jwt_payload
      JWT.decode(request.headers['Authorization'].split.last,
                 Rails.application.credentials.devise_jwt_secret_key!).first
    end

    def find_current_user(user_id)
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def render_unauthorized
      render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
    end

    def render_success_message(current_user)
      render json: { status: 200, message: "#{current_user.email} has logged out successfully." }, status: :ok
    end
  end
end
