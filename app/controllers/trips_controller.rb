class TripsController < ApplicationController

	def index
		# DASHBOARD: ALL TRIPS
    # @user = User.find(params[:user_id])
	end

	def show
		#TRIP STATUS (depending on whether I have voted already)
		#show members (accepted, declined, pending, voted)
		#show final destination when available or time is out
	end

	def new
		#group leader creates a trip and
		#select name and destinations
	end

	def create
		#post >>> save trip to DB
	end

	def edit
		#add friends to the trip
	end

	def update
		#post >>> update the friends' list
	end

	def destroy
		#allow group leader to delete a trip he has created
	end
end
