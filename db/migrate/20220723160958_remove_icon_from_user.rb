class RemoveIconFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :icon, :binary
    add_column :users, :image_name, :string 
  end
end
