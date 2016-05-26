require 'rails_helper'

RSpec.describe 'Unread messages', type: :request do
  let(:user) { create :user }
  let(:chat) { create :chat }
  let(:message) { create :message, user: user, chat: chat }
  let(:headers) do
    { 'Authorization' => "Token token=#{user.auth_token}" }
  end
  describe 'DELETE /chats/:chat_id/unread_messages/:message_id' do
    let(:req) do
      delete "/chats/#{chat.id}/unread_messages/#{message.id}", {}, headers
    end

    it 'fails without token' do
      delete "/chats/#{chat.id}/unread_messages/#{message.id}.json"
      expect(response.status).to eq 401
    end

    context 'when alias chat' do
      it 'renders not authorized error' do
        req
        expect(json).to include 'error'
      end
    end

    context 'when participate in chat' do
      let!(:chat_user) { create :chat_user, user: user, chat: chat }

      it 'invoke chat_user mark_read method' do

      end
    end
  end
end