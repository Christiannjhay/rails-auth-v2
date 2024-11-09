class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token
  helper_method :current_user
  
  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])  # Check if session has user_id
      @current_user ||= User.find_by(id: user_id)  # Fetch user from database
    end  # If no user_id in session, current_user remains nil
  end

  # This method checks if the user is logged in. If not, it redirects them to the login page.
  def require_login
    if current_user.nil?
      redirect_to login_path, alert: 'Your session has expired. Please log in again.'
    end
  end

end
