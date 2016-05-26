require 'rails_helper'

RSpec.describe SessionsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/sessions.json').to route_to 'sessions#create', format: 'json'
    end
  end
end