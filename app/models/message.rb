class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :user, presence: true
  validates :chat, presence: true
  validates :body, presence: true

  after_create :update_unread_messages
  after_create :update_user_messages_count

  private

  def update_unread_messages
    chat_users = chat.chat_users.where.not(user_id: user.id)
    chat_users.increment_counter(:unread_messages_count, 1)
  end

  def update_user_messages_count
    user.increment(:messages_count, 1)
  end
end
