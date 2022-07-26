class Inn < ApplicationRecord
  belongs_to :user
  has_many :reservations, foreign_key: "inn_id"
  validates :name, {presence: true}
  validates :area, {presence: true}
  validates :address, {presence: true}
  validates :price, {presence: true}
  validates :introduction, {presence: true}
end
