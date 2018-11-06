# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)

puts "Destroying all the records.."

Destination.destroy_all
Trip.destroy_all
Vote.destroy_all
UserTrip.destroy_all
User.destroy_all

puts "Creating group leader.."

puts "---------------------"
puts "Login:"
puts "test@test.com"
puts "pass: 123456"
puts "---------------------"
groupleader = User.create!(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "Group", last_name: "Leader", phone_number: "3342922333" )

puts "Creating friends.."

user_first_names = ["Marco", "Luca", "Anders", "Alessandra", "Cristina", "George"]
user_last_names = ["Rossi", "Bianchi", "Anderson", "Wong", "Smitt", "Jackson"]
emails = ["one@gmail.com", "two@gmail.com", "three@gmail.com", "four@gmail.com", "five@gmail.com" ]
phone_numbers = ["3342900726", "3342900727", "3342900728"]

emails.each do |email|
	phone_number = 3342900726
	User.create!(first_name: user_first_names.sample, last_name: user_last_names.sample, email: email, password: "123456", password_confirmation: "123456", phone_number: phone_number.to_s )
	phone_number += 1
end 

puts "Creating trips.."

["Vamos", "LetsGo", "Hasta Luego"].each do |trip_name|
	Trip.create!(name: trip_name, picture: "https://source.unsplash.com/random", user: groupleader)
end 

puts "Creating user_trips.."

Trip.all.each do |trip|
	User.all.each do |user|
		UserTrip.create!(trip: trip, user: user, state: "accepted")	
	end
end

puts "Creating destinations.."

cities = ["Barcelona", "Bali", "Bangkok", "Los Angeles", "Lima", "Seoul", "Sydney", "New York", "Berlin"]
countries = ["Spain", "Indonesia", "Thialand", "United States", "Peru", "South Korea", "Australia", "United States", "Berlin"]

Trip.all.each do |trip|
	cities.each_with_index do |city, index|
    	country = countries[index]
    	Destination.create!(city: city, country: country, trip: trip)
	end
end



