require 'rails_helper'

RSpec.describe MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/chats/1/messages.json')
        .to route_to 'messages#index', chat_id: '1', format: 'json'
    end

    it 'routes to #create' do
      expect(post: '/chats/1/messages.json')
        .to route_to 'messages#create', chat_id: '1', format: 'json'
    end
  end
end