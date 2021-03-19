class ApplicationController < ActionController::Base
include SessionHelper

  private
  def logged_in_user
      unless logged_in?
        # store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end

  def set_no_cache
    response.headers['Cache-Control'] = 'no-cache, no-store,
                                        max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
