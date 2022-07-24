class User < ApplicationRecord
    has_secure_password
    validates :name, {presence: true}
    validates :account_name, {presence: true}
    validates :phone_number, {presence: true, length: {in: 10..11}}
    validates :introduction, {length: {maximum: 160}}
    validates :password_digest, {presence: true}
end
