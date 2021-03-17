class RemoveBdayFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :birthday 
  end
end
