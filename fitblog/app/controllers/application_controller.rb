class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  helper_method :user_signed_in?
  
  # prevent from being used as actions on other contollers (called by paths/routes)
  private
  
    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
  
    def user_signed_in?
      current_user.present?
    end
  
    def require_authentication
      if current_user.nil?
        redirect_to new_session_url
      end
    end

    def fitbit_client
      Fitgem::Client.new({:consumer_key => 'abc123', :consumer_secret => 'def456', :token => 'pqr161718', :secret => 'stu192021'})
    end
end
