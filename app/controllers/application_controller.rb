class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :auth_filter
  
  
  
  def auth_filter
    unless session[:user_id].nil?
      @user = User.find session[:user_id]
    end
  end
  
end
