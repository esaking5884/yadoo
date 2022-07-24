class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :account_name
      t.string :email
      t.string :phone_number
      t.text :introduction
      t.binary :icon

      t.timestamps
    end
  end
end
