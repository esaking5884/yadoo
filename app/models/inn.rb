class Inn < ApplicationRecord
  validates :name, {presence: true}
  validates :area, {presence: true}
  validates :address, {presence: true}
  validates :price, {presence: true}
  validates :introduction, {presence: true}
end
