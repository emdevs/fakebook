class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.integer :requester_id
      t.integer :reciever_id

      t.timestamps
    end
  end
end
