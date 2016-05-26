require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it do
      is_expected.to validate_numericality_of(:messages_count)
        .is_greater_than_or_equal_to(0).only_integer
    end
  end
end
