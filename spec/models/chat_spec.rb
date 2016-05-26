require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of :title }
  end
end
