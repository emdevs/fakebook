class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.integer :club_id
      t.integer :member_id
      t.boolean :blocked, default: false

      t.timestamps
    end
  end
end
