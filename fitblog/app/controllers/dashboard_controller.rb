class DashboardController < ApplicationController
  before_action :require_authentication
  
  def index
  	@badges = fitbit_client.badges['badges']
  end
end
