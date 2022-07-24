class Inn < ActiveRecord::Migration[6.1]
  def change
    create_table :inns do |t|
      t.string :owner
      t.string :name
      t.string :price
      t.string :area
      t.string :address
      t.string :image_name
      t.text :introduction

      t.timestamps
    end
  end
end
