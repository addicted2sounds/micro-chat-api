require 'rails_helper'

RSpec.describe ChatsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/chats.json').to route_to 'chats#index', format: 'json'
    end

    it 'routes to #create' do
      expect(post: '/chats.json').to route_to 'chats#create', format: 'json'
    end

    it 'routes to #update' do
      expect(patch: '/chats/1.json').to route_to 'chats#update',
                                                 id: '1', format: 'json'
    end
  end
end