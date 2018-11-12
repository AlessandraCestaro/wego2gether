class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :current_invited_user

  def current_invited_user
  	User.find_by(id: session[:invited_user_id]) #it returns nil if it doesn't find any record with that id
  end
end
