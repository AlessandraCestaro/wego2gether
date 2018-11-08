class UserTripsController < ApplicationController

	def show
		#show the invite to the friend
    @trip = Trip.find(params[:trip_id])
    @user_trip = UserTrip.find_by(trip_id: @trip.id, user_id: @trip.user_id)
	end

	def update
		#change the state from pending to accepted or declined
    @trip = Trip.find(params[:trip_id])
    @user_trip = UserTrip.find_by(trip_id: @trip.id, user_id: @trip.user_id)
    @user_trip.update(params[:user_trip].permit!)

    if params[:user_trip][:state] == "accepted"
      redirect_to new_trip_vote_path(@trip.id)
    else
      redirect_to declined_trip_user_trip_path(@trip.id)
    end
	end
end
