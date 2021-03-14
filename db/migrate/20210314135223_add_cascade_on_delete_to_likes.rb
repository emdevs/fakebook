class AddCascadeOnDeleteToLikes < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :likes, :posts
    remove_foreign_key :likes, :users

    add_foreign_key :likes, :posts, on_delete: :cascade
    add_foreign_key :likes, :users, on_delete: :cascade
  end
end
