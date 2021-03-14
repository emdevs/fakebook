class AddForeignKeyAndCascadeDeleteToFriendRequests < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :friend_requests, :users, column: :requester_id, on_delete: :cascade
    add_foreign_key :friend_requests, :users, column: :reciever_id, on_delete: :cascade
  end
end
