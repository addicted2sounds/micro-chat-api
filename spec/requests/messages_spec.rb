require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let!(:chat) { create :chat }
  let!(:user) { create :user }
  let(:message) { create :message, chat: chat }
  let(:valid_attributes) { attributes_for :message }
  let(:invalid_attributes) { attributes_for :message, body: '' }
  let(:headers) do
    { 'Authorization' => "Token token=#{user.auth_token}" }
  end
  describe 'GET /messages.json' do
    let(:req) do
      get "/chats/#{chat.id}/messages.json", valid_attributes, headers
    end

    let!(:chat_user) { create :chat_user, chat: chat, user: user }
    it 'fails without token' do
      get "/chats/#{chat.id}/messages.json", valid_attributes
      expect(response.status).to eq 401
    end

    context 'when no messages exist' do
      it 'returns empty list' do
        req
        expect(json).to eq []
      end
    end

    context 'when messages exist' do
      let!(:message) { create :message, chat: chat }

      it 'return message' do
        req
        expect(json.length).to eq 1
      end
    end
  end

  describe 'POST /messages.json' do
    context 'when posting to alias chat' do
      let(:chat) { create :chat }
      let(:req) do
        post "/chats/#{chat.id}/messages.json", { message: valid_attributes },
             headers
      end

      it 'raise exception' do
        req
        expect(response.status).to eq 401
      end
    end
    context 'when valid params' do
      let!(:chat_user) { create :chat_user, chat: chat, user: user }
      let(:req) do
        post "/chats/#{chat.id}/messages.json", { message: valid_attributes },
             headers
      end

      it 'returns valid status' do
        req
        expect(response.status).to eq 200
      end

      it 'returns message' do
        req
        expect(json['body']).to eq valid_attributes[:body]
      end
    end

    context 'when invalid params' do
      let!(:chat_user) { create :chat_user, chat: chat, user: user }
      let(:req) do
        post "/chats/#{chat.id}/messages.json",
             { message: invalid_attributes }, headers
      end

      it 'return invalid status' do
        req
        expect(response.status).to eq 422
      end

      it 'returns error for the field' do
        req
        expect(json).to include 'body'
      end
    end
  end
end
