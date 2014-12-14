module SessionsHelper

  @current_user = nil

  def log_in(user)
    session[:user_id] = user.id
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    # Returns true is there is a current user
    return !current_user.nil?
  end

  def current_user
    # "Cache" the current user in a instance variable
    # Using User.find(id) would raise an exception for non-existent users
    return @current_user ||= User.find_by(id: session[:user_id])
  end
end
