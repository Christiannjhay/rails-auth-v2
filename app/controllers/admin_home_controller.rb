class AdminHomeController < ApplicationController
  include AdminSessionHelper

  before_action :require_admin
  
  def new
  end
end
