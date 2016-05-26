require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /sessions' do
    let(:user) { create :user, password: '123qwe' }
    let(:valid_attributes) { { name: user.name, password: '123qwe' } }
    let(:invalid_credentials) { { name: 'None', password: '111' } }
    context 'when valid credentials' do
      let(:request) { post '/sessions.json', valid_attributes }
      it 'return normal state' do
        request
        expect(response.status).to eq 200
      end

      it 'returns requested user' do
        request
        expect(json).to include 'name' => user.name
      end
    end

    context 'when invalid credentials' do
      let(:request) { post '/sessions.json', invalid_credentials }
      it 'returns unprocessable entity status' do
        request
        expect(response.status).to eq 422
      end

      it 'has error description' do
        request
        expect(json).to include 'error' => 'Invalid credentials'
      end
    end
  end
end
