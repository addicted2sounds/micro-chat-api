class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :messages_count, numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
  }

  before_create :generate_token

  def generate_token
    begin
      self.auth_token = SecureRandom.uuid
    end while self.class.exists? auth_token: auth_token
  end
end
