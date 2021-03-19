class SessionsController < ApplicationController
    def new
    end

    def create
        #check if the user exists and if the password entered is correct
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in user
            session[:user_id] = user.id
            remember user

            redirect_to user_notes_url(user.id)
        else
            flash.now.alert = 'Email or password is invalid'
            render :new
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_url, notice: 'Logged out!'
    end
end