class ChangeLikesTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :likeable_id
    add_column :likes, :likeable_type, :string

    add_index :likes, [:likeable_type, :likeable_id]

    remove_foreign_key :likes, :posts
    # add_foreign_key :likes, :likeable, on_delete: :cascade (maybe not necessary?)
  end
end
