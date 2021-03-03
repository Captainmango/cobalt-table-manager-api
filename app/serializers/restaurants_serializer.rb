class RestaurantsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :address, :image

  attribute :avg_rating do |restaurant|
    restaurant.avg_rating
  end

  has_many :reservations
  has_many :users

end
