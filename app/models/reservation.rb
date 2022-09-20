class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :inn
  
  with_options presence: true do
    validates :name
    validates :number_of_people, {numericality: {greater_than: 0}}
    validates :check_in
    validates :check_out
  end
  
  with_options on: :valid_date do
    validate :later_than_today
    validate :later_than_check_in
  end

  def later_than_check_in
    if check_in >= check_out
      errors.add(:check_out, "はチェックインより後に設定してください")
    end
  end

  def later_than_today
    today = Date.today
    if check_in < today
      errors.add(:check_in, "は今日より後に設定してください")
    end
  end
end
