class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :auth_token, null: false
      t.integer :messages_count, default: 0

      t.index :auth_token
      t.timestamps null: false
    end
  end
end
