class UserTripsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:show, :update, :declined]

	def show
		#show the invite to the friend
    @trip = Trip.find(params[:trip_id])
    @user_trip = UserTrip.find_by(trip_id: @trip.id, user_id: params[:id])
    session[:invited_user_id] = params[:id]
    end

    def update
        #change the state from pending to accepted or declined
    user_id = UserTrip.find(params[:id].to_i)[:user_id]
    session[:invited_user_id] = user_id
    @trip = Trip.find(params[:trip_id])
    @user_trip = UserTrip.find_by(trip_id: @trip.id, user_id: session[:invited_user_id])
    @user_trip.update(params[:user_trip].permit!)
    if params[:user_trip]["state"] == "ACCEPT"
        @user_trip.update(state: "accepted")
      redirect_to new_trip_vote_path(@trip.id)
    else
        @user_trip.update(state: "declined")
        redirect_to declined_trip_user_trip_path(@trip.id)
	end
    end

    def declined
    end
end


