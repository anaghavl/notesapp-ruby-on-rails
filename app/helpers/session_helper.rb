module SessionHelper

  #Store user session in cookie when logged in
  def log_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    session[:user_id] = user.id
    self.current_user = user
  end

  #Check if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end 

  #log out as user
  def log_out
    forget(current_user)
    self.current_user = nil
    session.delete(:user_id)

    cookies.delete(:remember_token)
  end

  # Remembers a user in the same session  session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end