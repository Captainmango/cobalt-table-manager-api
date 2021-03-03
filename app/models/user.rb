class User < ApplicationRecord
    has_many :reservations
    has_many :restaurants, through: :reservations

    validates_presence_of :email_address
    validates :email_address, uniqueness: true
    validates :username, uniqueness: true

    has_secure_password

end
