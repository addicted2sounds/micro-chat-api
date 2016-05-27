require 'rails_helper'

RSpec.describe 'Unread messages', type: :request do
  let(:user) { create :user }
  let(:chat) { create :chat }
  let!(:message) { create :message, chat: chat }
  let(:headers) do
    { 'Authorization' => "Token token=#{user.auth_token}" }
  end
  describe 'GET /chats/:chat_id/unread_messages' do
    let(:req) do
      get "/chats/#{chat.id}/unread_messages", {}, headers
    end

    it 'fails without token' do
      get "/chats/#{chat.id}/unread_messages.json"
      expect(response.status).to eq 401
    end

    context 'when alias chat' do
      it 'returns unauthorized status' do
        req
        expect(response.status).to eq 401
      end
    end

    context 'when participated chat' do
      let!(:chat_user) { create :chat_user, user: user, chat: chat }
      let!(:new_message) { create :message, chat: chat }

      it 'returns valid status' do
        req
        expect(response.status).to eq 200
      end

      context 'when last read message set' do
        before :each do
          chat_user.last_read_message = message
          chat_user.save
        end

        it 'returns new messages' do
          req
          expect(json.length).to eq 1
        end
      end

      context 'when last read message unset' do
        it 'returns all messages in chat' do
          req
          expect(json.length).to eq 2
        end
      end
    end
  end

  describe 'DELETE /chats/:chat_id/unread_messages/:message_id' do
    let(:req) do
      delete "/chats/#{message.chat.id}/unread_messages/#{message.id}", {}, headers
    end

    it 'fails without token' do
      delete "/chats/#{chat.id}/unread_messages/#{message.id}.json"
      expect(response.status).to eq 401
    end

    context 'when alias chat' do
      it 'returns not authorized status' do
        req
        expect(response.status).to eq 401
      end
    end

    context 'when participate in chat' do
      let!(:chat_user) { create :chat_user, user: user, chat: chat }

      it 'sets last read message for chat user' do
        req
        chat_user.reload
        expect(chat_user.last_read_message_id).to eq message.id
      end
    end
  end
end