require 'rails_helper'

RSpec.describe UnreadMessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/chats/1/unread_messages.json')
          .to route_to 'unread_messages#index', format: 'json', chat_id: '1'
    end

    it 'routes to #destroy' do
      expect(delete: '/chats/1/unread_messages/1.json')
          .to route_to 'unread_messages#destroy', format: 'json', chat_id: '1',
          unread_message_id: '1'
    end
  end
end