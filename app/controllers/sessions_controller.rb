class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(nick: params[:session][:nick])
    if user && user.authenticate(params[:session][:password])
      # Sucess!
      log_in user
      redirect_to user
    else
      # Invalid login credentials
      flash.now[:danger] = "Wrong nick/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
