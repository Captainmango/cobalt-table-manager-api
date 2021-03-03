class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :restaurant
    after_initialize :set_rating

    def set_rating
        self.rating ||= 0
    end

    validates_presence_of :diners, :time, :restaurant_id
end
