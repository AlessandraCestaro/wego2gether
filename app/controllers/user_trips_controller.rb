class UserTripsController < ApplicationController

	def show
		#show the invite to the friend
	end

	def update
		#change the state from pending to accepted or declined
	end

	def declined
        #@user_trip = UserTrip.find(params[:id])
        #@user_trip.update[state: "pending"]
    end
end
