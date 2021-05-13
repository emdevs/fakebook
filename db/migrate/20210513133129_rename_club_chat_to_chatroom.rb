class RenameClubChatToChatroom < ActiveRecord::Migration[6.1]
  def change
    rename_table :club_chats, :chatrooms
  end
end
