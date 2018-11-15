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
groupleader1 = User.create!(email: "ale@gmail.com", password: "123456", password_confirmation: "123456", first_name: "Ale", last_name: "Sandra", phone_number: "3342922333" )
groupleader2 = User.create!(email: "test2@test.com", password: "123456", password_confirmation: "123456", first_name: "GL2", last_name: "Leader2", phone_number: "3342922334" )


# Ale's account
# ale = User.create!(email: "acestaro@gmail.com", password: "alealeale", password_confirmation: "alealeale", first_name: "Alessandra", last_name: "Cestaro", phone_number: "+393452504867")

# REGULAR SEEDS
puts "Creating trips by groupleader1.."

date = Date.today + 7

["Vamos", "LetsGo", "Hasta Luego"].each do |trip_name|
  Trip.create!(name: trip_name, picture: "https://source.unsplash.com/random", user: groupleader1, deadline_date: date)
end

puts "Creating trips by groupleader2.."

["Summer2019", "NewYearsEve", "SpringBreak"].each do |trip_name|
  Trip.create!(name: trip_name, picture: "https://source.unsplash.com/random", user: groupleader2, deadline_date: date)
end

puts "Creating expired trips by groupleader1.."

  old_date = Date.today - 7

  old_trip_1 = Trip.create!(name: "EasterHoliday", picture: "https://source.unsplash.com/random", user: groupleader1, deadline_date: old_date)

puts "Creating expired trips by groupleader2.."

  old_trip_2 = Trip.create!(name: "SkiWeek", picture: "https://source.unsplash.com/random", user: groupleader2, deadline_date: old_date)

puts "Creating user_trips for groupleaders1 and 2.."
groupleaders = [groupleader1, groupleader2]

groupleaders.each do |gl|
  gl.managed_trips.each do |trip|
    UserTrip.create!(user: gl, trip: trip, state: "accepted")
  end
end

puts "Inviting groupleaders to one anothers' managed_trips..."
UserTrip.create!(user: groupleader1, trip: groupleader2.managed_trips.sample)
UserTrip.create!(user: groupleader2, trip: groupleader1.managed_trips.sample)


puts "Creating friends and their user_trips.."

user_first_names = ["Marco", "Luca", "Anders", "Alessandra", "Cristina", "George"]
user_last_names = ["Rossi", "Bianchi", "Anderson", "Wong", "Smitt", "Jackson"]
emails = ["one@gmail.com", "two@gmail.com", "three@gmail.com", "four@gmail.com", "five@gmail.com" ]
phone_numbers = ["3342900726", "3342900727", "3342900728"]
state = ["accepted", "pending", "declined"]

emails.each do |email|
  phone_number = 3342900726
  user = User.create!(first_name: user_first_names.sample, last_name: user_last_names.sample, email: email, password: "123456", password_confirmation: "123456", phone_number: phone_number.to_s )
  UserTrip.create!(user: user, trip: Trip.all.sample)
  phone_number += 1
end

puts "Creating destinations.."

cities = ["Barcelona", "Bali", "Bangkok", "Los Angeles", "Lima"]
countries = ["Spain", "Indonesia", "Thialand", "United States", "Peru"]

Trip.all.each do |trip|
	cities.each_with_index do |city, index|
    	country = countries[index]
    	Destination.create!(city: city, country: country, trip: trip)
	end
end

puts "Creating votes.."

User.all.sample(5).each do |user|
	user.user_trips.update(state: "accepted")
    user.trips.each do |trip|
		  trip.destinations.each do |destination|
			 Vote.create!(user: user, destination: destination, rating: rand(0..5))
		end
	end
end

