class Inn < ApplicationRecord
  belongs_to :user, foreign_key: "owner"
  has_many :reservations, dependent: :destroy
  validates :name, {presence: true}
  validates :area, {presence: true}
  validates :address, {presence: true}
  validates :price, {presence: true, numericality: {greater_than: 99}}
  validates :introduction, {presence: true}
end
