class ReservationsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :time, :diners, :rating

  attribute :restaurant do |reservation|
    reservation.restaurant
  end

  belongs_to :user
  belongs_to :restaurant
end
