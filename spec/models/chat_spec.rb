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
end
