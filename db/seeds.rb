# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# unsplash URL for random pic in meals collection: https://source.unsplash.com/collection/4173854

admin = User.create(first_name: "Edward", 
                    last_name: "Heaver", 
                    username: "Edward21", 
                    password: "123456", 
                    email_address: "test@test.com",
                    mobile_number: "+447931555501")
admin.save

10.times do
    nu_restaurant = Restaurant.create(name: Faker::Company.name,
                      address: Faker::Address.full_address,
                      image: "https://source.unsplash.com/collection/4173854")
    nu_restaurant.save
end

20.times do
    restaurant = Restaurant.find(rand(1..10))
    nu_reservation = admin.reservations.create(restaurant_id: restaurant.id, 
                                               diners: rand(2..8), 
                                               time: rand(30.days).seconds.from_now, 
                                               rating: rand(2..5))
    nu_reservation.save
end






