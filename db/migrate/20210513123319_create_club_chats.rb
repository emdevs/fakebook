class CreateClubChats < ActiveRecord::Migration[6.1]
  def change
    create_table :club_chats do |t|
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
