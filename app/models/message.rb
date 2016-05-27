class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  validates :user, presence: true
  validates :chat, presence: true
  validates :body, presence: true

  after_create :update_unread_messages!
  after_create :update_user_messages_count!

  def chat_user
    @chat_user ||= chat.chat_users.find_by user: user
  end

  def set_last_read!(user)
    chat_user = chat.chat_users.where(user: user).first
    chat_user.update_attribute :last_read_message_id, id if chat_user
  end

  private

  def update_unread_messages!
    chat_users = chat.chat_users.where.not(user_id: user.id)
    # chat_users.update_al
    # p chat_users
    chat_users.update_all('unread_messages_count = unread_messages_count + 1')
    # chat_users.increment_counter(:unread_messages_count, 1)
  end

  def update_user_messages_count!
    user.increment(:messages_count, 1)
  end
end
