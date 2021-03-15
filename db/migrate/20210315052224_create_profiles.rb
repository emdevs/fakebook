class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :bio
      t.date :birthday

      t.timestamps
    end
  end
end
