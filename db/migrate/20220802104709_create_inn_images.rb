class CreateInnImages < ActiveRecord::Migration[6.1]
  def change
    create_table :inn_images do |t|
      t.integer :inn_id
      t.string :image_name
      t.integer :order

      t.timestamps
    end
  end
end
