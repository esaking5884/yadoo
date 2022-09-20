class ChangeDatatypePriceOfInns < ActiveRecord::Migration[6.1]
  def change
    change_column :inns, :price, :integer
  end
end
