require 'rails_helper'

RSpec.describe ChatUser, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :chat }
  end

  describe 'validations' do
    it 'validates unread messages count' do
      is_expected.to validate_numericality_of(:unread_messages_count)
        .is_greater_than_or_equal_to(0).only_integer
    end
  end
end
