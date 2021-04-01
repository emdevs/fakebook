class CreateClubs < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs do |t|
      t.integer :owner_id
      t.string :name
      t.string :description
      t.integer :capacity

      t.timestamps
    end
  end
end
