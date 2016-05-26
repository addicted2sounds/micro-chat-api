require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  let!(:user) { create :user }
  let(:interlocutor) { create :user }
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

      it 'is empty when other chats exist' do
        create :chat
        req
        expect(json).to eq []
      end

      context 'when chats with user exist' do
        let(:chat) { create :chat }
        before :each do
          create :chat_user, chat: chat, user: user
        end

        it 'returns chat in list' do
          req
          expect(json.count).to eq 1
        end
      end
    end
  end

  describe 'POST /chats.json' do
    let(:valid_attributes) do
      attributes_for(:chat).merge(user_ids: [user.id, interlocutor.id])
    end

    let(:invalid_attributes) do
      attributes_for :chat, title: ''
    end

    it 'fails without token' do
      post '/chats.json', chat: valid_attributes
      expect(response.status).to eq 401
    end

    context 'when valid attributes' do
      let(:req) { post '/chats.json', { chat: valid_attributes }, headers }

      it 'returns success status' do
        req
        expect(response.status).to eq 200
      end

      it 'creates chat' do
        expect { req }.to change(Chat, :count).by 1
      end

      it 'creates chat users' do
        expect { req }.to change(ChatUser, :count).by 2
      end

      it 'return created chat' do
        req
        expect(json).to include 'title' => Chat.last.title
      end
    end

    context 'when invalid attributes' do
      let(:req) { post '/chats.json', { chat: invalid_attributes }, headers }

      it 'return unprocessable entity status' do
        req
        expect(response.status).to eq 422
      end

      it 'returns error description' do
        req
        expect(json).to include 'title'
      end
    end

    context 'when not enough users' do
      let(:req) { post '/chats.json', { chat: attributes_for(:chat) }, headers }

      it 'returns error' do
        req
        expect(json).to include 'users'
      end
    end
  end

  describe 'PATCH /chats/:id.json' do
    let(:chat) { create :chat }
    let(:valid_attributes) { attributes_for(:chat) }
    let(:invalid_attributes) { attributes_for(:chat, title: '') }
    context 'when changing anticipated chat' do
      let(:req) do
        patch "/chats/#{chat.id}.json", { chat: valid_attributes }, headers
      end
      before :each do
        chat.users << user
      end

      context 'with valid attributes' do
        it 'return valid status' do
          req
          expect(response.status).to eq 200
        end

        it 'returns new attributes' do
          req
          expect(json['title']).to eq valid_attributes[:title]
        end

        describe 'changing anticipated users' do
          it 'remove user from chat_users' do
            valid_attributes[:user_ids] = chat.users.map(&:id)
            valid_attributes[:user_ids].pop
            expect {
              patch "/chats/#{chat.id}.json", { chat: valid_attributes }, headers
            }.to change(ChatUser, :count).by -1
          end

          it 'add new user to chat_users' do
            valid_attributes[:user_ids] = chat.users.map(&:id)
            valid_attributes[:user_ids].push(create(:user).id)
            expect {
              patch "/chats/#{chat.id}.json", { chat: valid_attributes }, headers
            }.to change(ChatUser, :count).by 1
          end
        end
      end

      context 'with invalid attributes' do
        let(:req) do
          patch "/chats/#{chat.id}.json", { chat: invalid_attributes }, headers
        end

        it 'returns unprocessable status' do
          req
          expect(response.status).to eq 422
        end
      end
    end

    context 'when changing not anticipated chat' do
      let(:req) do
        patch "/chats/#{chat.id}.json", { chat: valid_attributes }, headers
      end

      it 'returns unprocessable status' do
        req
        expect(response.status).to eq 401
      end
    end
  end
end
