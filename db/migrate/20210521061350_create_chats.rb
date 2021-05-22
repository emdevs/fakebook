class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user_1
      t.references :user_2
      t.timestamps
    end

    add_foreign_key :chats, :users, column: :user_1_id, primary_key: :id
    add_foreign_key :chats, :users, column: :user_2_id, primary_key: :id
  end
end
