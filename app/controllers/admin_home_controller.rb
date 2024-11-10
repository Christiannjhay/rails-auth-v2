class AdminHomeController < ApplicationController
  include AdminSessionHelper

  before_action :require_admin
  
  def new
    @hotels = Hotel.all
  end
end
