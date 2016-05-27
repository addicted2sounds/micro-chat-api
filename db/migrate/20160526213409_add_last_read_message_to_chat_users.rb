class AddLastReadMessageToChatUsers < ActiveRecord::Migration
  def change
    add_reference :chat_users, :last_read_message, references: :messages,
                  index: true
    add_foreign_key :chat_users, :messages, column: :last_read_message_id
  end
end
