# frozen_string_literal: true

describe Users::SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'login').to route_to('users/sessions#create')
    end

    it 'routes to #destroy' do
      expect(delete: 'logout').to route_to('users/sessions#destroy')
    end
  end
end
