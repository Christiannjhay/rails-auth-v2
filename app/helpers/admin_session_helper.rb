module AdminSessionHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Checks if the current user is an admin
  def is_admin?
    current_user && current_user.admin?
  end

  # Redirects to the login page if the user is not an admin
  def require_admin
    unless is_admin?
      flash[:alert] = "Access denied. Admins only."
      redirect_to login_path
    end
  end

  # Logs out the current user.
  def log_out
    reset_session
    @current_user = nil 
  end

end
