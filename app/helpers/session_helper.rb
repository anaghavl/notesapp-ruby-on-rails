# module SessionHelper
#     def log_in(user)
#       cookies.permanent[:remember_token] = user.remember_token
#       session[:user_id] = user.id
#     end
  
#     def current_user
#       if session[:user_id]
#         @current_user ||= User.find_by_remember_token(cookies[:remember_token])

#         # @current_user ||= User.find_by(id: session[:user_id])
#       end
#     end
  
#     def logged_in?
#       !current_user.nil?
#     end
  
#     def log_out
#       cookies.delete(:remember_token)
#       session.delete(:user_id)
#       @current_user = nil
#     end
  
#     def current_user?(user)
#       user == current_user
#     end
  
#     def redirect_back_or(default)
#       redirect_to(session[:forwarding_url] || default)
#       session.delete(:forwarding_url)
#     end
  
#     def store_location
#       session[:forwarding_url] = request.original_url if request.get?
#     end

#     private

#     def user_from_remember_token
#       User.authenticate_with_salt(*remember_token)
#     end
    
#     def remember_token
#       cookies.signed[:remember_token] || [nil, nil]
#     end
#   end
module SessionHelper

  def log_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    
    session[:user_id] = user.id
    self.current_user = user
  end

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

  # def current_user
  #   remember_token = User.encrypt(cookies[:remember_token])
  #   byebug
  #   @current_user ||= User.find_by(remember_token: remember_token)
  # end

  def current_user=(user)
    @current_user = user
  end

  # def current_user
  #   @current_user ||= User.find_by(cookies[:remember_token])
  # end

  def current_user?(user)
    user == current_user
  end 

  def log_out
    forget(current_user)
    self.current_user = nil
    session.delete(:user_id)

    cookies.delete(:remember_token)
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end