class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :user, presence: true
  validates :chat, presence: true
  validates :body, presence: true
end
