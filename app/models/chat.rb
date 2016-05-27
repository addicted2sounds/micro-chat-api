class Chat < ActiveRecord::Base
  has_many :chat_users
  has_many :users, through: :chat_users
  has_many :messages

  validates :title, presence: true, uniqueness: true
  validates :users, length: { minimum: 2, message: '2 users at least' }

  def unread_messages(user)
    chat_user = chat_users.find_by user: user
    if chat_user.last_read_message.present?
      messages.where('created_at > ?', chat_user.last_read_message.created_at)
    else
      messages
    end
  end
end
