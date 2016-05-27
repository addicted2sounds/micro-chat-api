class Chat < ActiveRecord::Base
  has_many :chat_users
  has_many :users, through: :chat_users
  has_many :messages

  validates :title, presence: true, uniqueness: true
  validates :users, length: { minimum: 2, message: '2 users at least' }
end
