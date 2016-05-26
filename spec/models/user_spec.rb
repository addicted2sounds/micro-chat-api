require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it 'validates message_count numericality' do
      is_expected.to validate_numericality_of(:messages_count)
        .is_greater_than_or_equal_to(0).only_integer
    end
    it { is_expected.to have_secure_password }
  end
end
