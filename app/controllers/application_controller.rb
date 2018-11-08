class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def current_invited_user
    User.first # temporary, only here to test a controller
    # User.find_by(id: session[:invited_user_id])
  end
end
