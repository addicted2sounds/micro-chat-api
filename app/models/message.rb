class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :body, presence: true
end
