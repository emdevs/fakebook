class AddUniqueIndexToMemberships < ActiveRecord::Migration[6.1]
  def change
    add_index :memberships, [:club_id, :member_id], unique: true
  end
end
