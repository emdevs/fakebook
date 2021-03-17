class RenameBdayInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :birthday, :birth_date
  end
end
