module SessionsHelper

  @current_user = nil

  def log_in(user)
    session[:user_id] = user.id
  end
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember_me
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end
  def forget(user)
    user.forget_me
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    # Returns true is there is a current user
    return !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id]) # Already logged in and authenticated
      return @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id]) # Remembered but not logged in
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies.signed[:remember_token])
        log_in user
        return @current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  #Friendly redirect (ugh!)
  def fr_store # Only for GET
    session[:forward_to] = request.url if request.get?
  end
  def fr_redir(default)
    redirect_to(session[:forward_to] || default)
    session.delete(:forward_to)
  end

end
