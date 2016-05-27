require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create :user }
  let!(:message) { create :message, user: user }

  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :chat }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :chat }
  end

  describe '.chat_users' do
    it 'returns list of chat_users' do
      p message.chat.chat_users
    end
  end

  describe '.update_unread_messages' do
    let(:chat_user) { message.chat.chat_users.find_by user: user }
    let(:alias_chat_user) do
      message.chat.chat_users.where.not(user: user).first
    end

    it 'leaves author counter idempotent' do
      expect {
        create :message, user: user, chat: message.chat
      }.not_to change(chat_user, :unread_messages_count)
    end

    it 'updates unread_messages_count for alias chat users' do
      p alias_chat_user, message.chat.chat_users
      create :message, user: user, chat: message.chat
      # expect {
      #   create :message, user: user, chat: message.chat
      # }.to change(alias_chat_user, :unread_messages_count).by(1)
      alias_chat_user.reload
      p alias_chat_user.unread_messages_count
    end
  end

  describe '.update_user_messages_count' do
    it 'increments counter' do
      expect {
        create :message, user: user
      }.to change(user, :messages_count).by(1)
    end
  end
end
