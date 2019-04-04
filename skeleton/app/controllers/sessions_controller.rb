class SessionsController < ApplicationController

  def new
  end

  def create
    #verify the user
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])


    if @user
      # login!(@user)
      @user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ["INVALID CREDENTIALS"]
      render :new
    end
  end

  def destroy
    user = current_user

    if user
      user.reset_session_token!
      session[:session_token] = nil
    end

    @current_user = nil
  end

end