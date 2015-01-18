class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(nick: params[:session][:nick])
    if @user && @user.authenticate(params[:session][:password])
      # Sucess!
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      fr_redir @user #Friendly Redirect: Go back to where it was
    else
      # Invalid login credentials
      flash.now[:danger] = "Wrong nick/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
