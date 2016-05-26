require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users.json').to route_to 'users#index', format: 'json'
    end

    it 'routes to #create' do
      expect(post: '/users.json').to route_to 'users#create', format: 'json'
    end
  end
end