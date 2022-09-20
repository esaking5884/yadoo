class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :inn_id
      t.integer :number_of_people
      t.date :check_in
      t.date :check_out
      t.integer :total_fee

      t.timestamps
    end
  end
end
