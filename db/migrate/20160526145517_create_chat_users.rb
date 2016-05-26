class CreateChatUsers < ActiveRecord::Migration
  def change
    create_table :chat_users do |t|
      t.references :chat, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :unread_messages_count, default: 0

      t.timestamps null: false
    end
  end
end
