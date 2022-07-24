class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "ログインしました"
      log_in(user)
      redirect_to user_path(user)
    else
      @email = params[:session][:email]
      @password = params[:session][:password]
      flash[:notice] = "ログインできませんでした"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
  end
end
