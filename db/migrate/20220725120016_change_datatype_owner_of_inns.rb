class ChangeDatatypeOwnerOfInns < ActiveRecord::Migration[6.1]
  def change
    change_column :inns, :owner, :integer
  end
end
