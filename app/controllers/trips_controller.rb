class TripsController < ApplicationController
	
	def index
		# DASHBOARD: ALL TRIPS
		# managed:
		# current_user.managed_trips.each do |trip|
		# end

		# invited:
		# @user.trips.each do |trip|
		 # if trip.user_id != current_user
		  # display
		#end
	end

	def show
		#TRIP STATUS
		#show members (accepted, declined, pending, voted)
		#show final destination when available or time is out
	end

	def new
		#group leader creates a trip and 
		#select name and destinations
		@trip = Trip.new
	end

	def create
		#post >>> save trip to DB
		date = Date.today + 7
		@trip = Trip.new(trip_params)
		@trip.deadline_date = date
		@trip.user_id = current_user[:id]
		@trip.save
		params["trip"]["destinations"].each do |destination|
			if !destination["city"].blank? #or use next
			  Destination.create(
				trip: @trip,
				city: destination["city"],
				country: destination["country"]
			  )
		    end
		end

		redirect_to edit_trip_path(@trip[:id])
	end

	def edit
		#add friends to the trip
		@trip = Trip.find(params[:id])

	end

	def update
		#post >>> update the friends' list
		@trip = Trip.find(params[:id])
		@trip.update(trip_params)
		user = current_user

		params["trip"]["friends"].each do |friend|
			if !friend["phone_number"].blank?
			  user = User.create(
				first_name: friend["first_name"],
				last_name: friend["last_name"],
				phone_number: friend["phone_number"],
			  )
			  UserTrip.create(
				trip_id: @trip[:id],
				user_id: user[:id],
				state: "pending"
		      )
		    end
		end

		redirect_to new_trip_vote_path(@trip)
	end

	def destroy
		#allow group leader to delete a trip he has created
	end

	private

    def trip_params
      params.require(:trip).permit(:name)
    end

end

### params in trips/new ###

#{"utf8"=>"✓", "authenticity_token"=>"Uaoy0j5MQLfX6j5P7MTml+TR1WKgjD74UWYb023akcKcn2x+KQwCGX5wchpgH8F1+oeFZGISUnMoUk2tQdPLtw==", 
#
# "trip"=>{
# 	"name"=>"trip test",
# 	"destinations"=>[
# 		{"city"=>"barcelona", "country"=>"ES"},
# 		{"city"=>"milan", "country"=>"IT"},
# 		{"city"=>"new york", "country"=>"US"}
# 	]
# }
#
# "commit"=>"Create your trip"}


### params in trips/:id/edit ###


#"trip"=><ActionController::Parameters 
# {"friends"=>[<ActionController::Parameters 
# {"first_name"=>"Bob", "last_name"=>"Bob", "phone_number"=>"555555555"} 
# permitted: false>, <ActionController::Parameters 
# {"first_name"=>"George", "last_name"=>"George", "phone_number"=>"666666666"} 
# permitted: false>, <ActionController::Parameters 
# {"first_name"=>"Tom", "last_name"=>"Tom", "phone_number"=>"3333333333"} 
# permitted: false>, <ActionController::Parameters 
# {"first_name"=>"Marta", "last_name"=>"Marta", "phone_number"=>"111111111"} 
# permitted: false>, <ActionController::Parameters 
# {"first_name"=>"", "last_name"=>"", "phone_number"=>""} permitted: false>]} 
# permitted: false>, "commit"=>"Send Invites", "controller"=>"trips", "action"=>"update", "id"=>"5"} permitted: false>