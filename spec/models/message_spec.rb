require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :chat }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end
end
