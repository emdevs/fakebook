class DropInvites < ActiveRecord::Migration[6.1]
  def change
    drop_table :invites do |t|
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
