class Inn < ApplicationRecord
  belongs_to :user
  validates :name, {presence: true}
  validates :area, {presence: true}
  validates :address, {presence: true}
  validates :price, {presence: true}
  validates :introduction, {presence: true}
end
