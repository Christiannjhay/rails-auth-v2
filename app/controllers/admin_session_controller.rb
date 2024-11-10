class AdminSessionController < ApplicationController
  include AdminSessionHelper
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      if user.admin?
        log_in user
        redirect_to admin_home_view_path
      else
        flash.now[:alert] = "You do not have the necessary admin role"
        render "new"
      end
    else
      flash.now[:alert] = "Invalid email/password combination"
      render "new"
    end
  end
end
