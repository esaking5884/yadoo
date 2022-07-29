class Reservation < ApplicationRecord
  belongs_to :user, dependent: destroy
  belongs_to :inn, dependent: destroy
end
