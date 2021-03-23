class UsersController < ApplicationController
    before_action :logged_in_user, only: [:show]

    def new
      @user = User.new
    end

    #Create users to join the application
    def create
      @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Welcome to notes app!"
        redirect_to user_notes_url(@user.id)
      else
        render 'new'
      end
    end

    private

    #Params for users to sign up
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end