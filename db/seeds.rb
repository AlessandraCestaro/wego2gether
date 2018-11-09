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

# Ale's account
ale = User.create!(email: "acestaro@gmail.com", password: "alealeale", password_confirmation: "alealeale", first_name: "Alessandra", last_name: "Cestaro", phone_number: "+393452504867")

# REGULAR SEEDS
puts "Creating trips.."

date = Date.today + 7

["Vamos", "LetsGo", "Hasta Luego"].each do |trip_name|
  Trip.create!(name: trip_name, picture: "https://source.unsplash.com/random", user: groupleader, deadline_date: date)
end

puts "Creating expired trips.."

old_date = Date.today - 7

["OldTrip1", "OldTrip2"].each do |trip_name|
  Trip.create!(name: trip_name, picture: "https://source.unsplash.com/random", user: groupleader, deadline_date: old_date)
end


puts "Creating user_trips.."

state = ["accepted", "pending", "declined"]

Trip.all.each do |trip|
  User.all.each do |user|
    UserTrip.create!(trip: trip, user: user)
  end
end

User.all[1].user_trips.update(state:"declined")


puts "Creating destinations.."

cities = ["Barcelona", "Bali", "Bangkok", "Los Angeles", "Lima", "Seoul", "Sydney", "New York", "Berlin"]
countries = ["Spain", "Indonesia", "Thialand", "United States", "Peru", "South Korea", "Australia", "United States", "Berlin"]

Trip.all.each do |trip|
	cities.each_with_index do |city, index|
    	country = countries[index]
    	Destination.create!(city: city, country: country, trip: trip)
	end
end


puts "Creating votes.."

User.last(3).each do |user|
	user.user_trips.update(state: "accepted")
    user.trips.each do |trip|
		  trip.destinations.each do |destination|
			 Vote.create!(user: user, destination: destination, rating: rand(0..5))
		end
	end
end

