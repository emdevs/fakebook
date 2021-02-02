class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end

    add_column :posts, :likes, :integer, default: 0
  end
end
