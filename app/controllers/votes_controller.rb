class VotesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]


	def new
		#votes page >>>> create an instance of vote
		#for each destination for the current_user
    @trip = Trip.find(params[:trip_id])
    @destinations = @trip.destinations
    @vote = Vote.new
    #need to pass on params of trip_id before opening this page
  end


 #  params = {
 # "destinations"=>
 #  [{"destination_id"=>"1", "rating"=>"3"},
 #   {"destination_id"=>"2", "rating"=>"1"},
 #   {"destination_id"=>"3", "rating"=>""},
 #   {"destination_id"=>"4", "rating"=>""},
 #   {"destination_id"=>"5", "rating"=>""},
 #   {"destination_id"=>"6", "rating"=>""},
 #   {"destination_id"=>"7", "rating"=>""},
 #   {"destination_id"=>"8", "rating"=>""},
 #   {"destination_id"=>"9", "rating"=>""}],
 # "trip_id"=>"1"}

  def create
    trip_params[:destinations].each do |vote|
      next if not vote[:rating].present?

      previous_one = Vote.where(destination_id: vote[:destination_id], user: current_invited_user).first
      next if previous_one

      @vote = Vote.new(vote.permit!)
      @vote.user = current_invited_user
      @vote.save
    end
    redirect_to trip_path(params[:trip_id])
	end


  def trip_params
    params
  end

end
