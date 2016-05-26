require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  let!(:user) { create :user }
  let :headers do
    { 'Authorization' => "Token token=#{user.auth_token}" }
  end

  describe 'GET /chats' do
    let(:req) { get '/chats.json', nil, headers }

    it 'fails without token' do
      get '/chats.json'
      expect(response.status).to eq 401
    end

    context 'when no chats with user' do
      it 'returns empty array' do
        req
        expect(json).to eq []
      end
    end
  end
end
