require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'relations' do
    it { is_expected.to have_many :chat_users }
    it { is_expected.to have_many(:users).through(:chat_users) }
    it { is_expected.to have_many(:messages) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of :title }
    # it { is_expected.to validate_length_of(:users).is_at_least(2) }
  end

  describe '.unread_messages' do
    let(:chat_user) { create :chat_user }
    let(:unread_messages) { chat_user.chat.unread_messages(chat_user.user) }

    context 'when last read message is not set' do
      context 'if no messages present' do
        it 'returns empty collection' do
          expect(unread_messages.to_a).to eq []
        end
      end

      context 'if messages present' do
        let!(:message) { create :message, chat: chat_user.chat }

        it 'returns all messages' do
          expect(unread_messages.to_a).to eq [message]
        end
      end
    end

    context 'when last read message is set' do
      let!(:last_message) { create :message, chat: chat_user.chat }
      before :each do
        chat_user.last_read_message = last_message
        chat_user.save!
      end

      context 'if last message is read' do
        it 'returns empty collection' do
          expect(unread_messages.to_a).to eq []
        end
      end

      context 'if messages present' do
        let!(:new_message) { create :message, chat: chat_user.chat }

        it 'returns all messages' do
          expect(unread_messages.to_a).to eq [new_message]
        end
      end
    end
  end
end
