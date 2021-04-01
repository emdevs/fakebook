class AddPostableColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :postable_id, :bigint
    add_column :posts, :postable_type, :string

    add_index :posts, [:postable_type, :postable_id]
  end
end
