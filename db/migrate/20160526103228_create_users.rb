class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :auth_token
      t.integer :messages_count, default: 0

      t.index :auth_token
      t.timestamps null: false
    end
  end
end
