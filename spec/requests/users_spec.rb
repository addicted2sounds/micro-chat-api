require 'rails_helper'

describe 'Users', type: :request do
  describe 'GET /users.json' do
    let!(:user) { create :user }
    let(:req) { get '/users.json', nil, headers }
    let(:subject) { req; json }
    let :headers do
      {
        'Authorization' => "Token token=#{user.auth_token}"
      }
    end

    it 'fails without token' do
      get '/users.json'
      expect(response.status).to eq 401
    end

    context 'when no users exist' do
      it { req; expect(json.count).to eq 1 }
    end

    context 'when users exist' do
      it 'return users list' do
        create :user
        req
        expect(json.count).to eq 2
      end
    end
  end

  describe 'POST /users.json' do
    let(:valid_params) { attributes_for :user }

    let(:invalid_params) { { name: '' } }
    context 'when valid params' do
      subject { post '/users.json', user: valid_params }

      it 'returns user hash' do
        subject
        expect(json).to include 'name' => valid_params[:name]
      end

      it 'creates new user' do
        expect { subject }.to change { User.count }.by 1
      end

      it 'returns required elements' do
        subject
        expect(json.keys).to eq %w(id name messages_count
                                    auth_token created_at)
      end
    end

    context 'when not valid params' do
      subject { post '/users.json', user: invalid_params }

      it 'returns unprocessable entry status' do
        subject
        expect(response.status).to eq 422
      end

      it 'has failed field in response' do
        subject
        expect(json).to include 'name'
      end

      context 'when name is already taken' do
        let!(:user) { create :user }
        let(:invalid_params) { { name: user.name } }

        it 'returns pretty message' do
          subject
          expect(json).to include 'name' => ['has already been taken']
        end
      end
    end
  end
end