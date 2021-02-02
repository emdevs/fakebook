class AddDefaultStatusToFriendRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :friend_requests, :status, :boolean, default: false
  end
end
