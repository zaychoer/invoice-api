# frozen_string_literal: true

describe Users::RegistrationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/signup').to route_to('users/registrations#create')
    end
  end
end
