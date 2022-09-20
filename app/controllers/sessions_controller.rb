class SessionsController < ApplicationController
  def new
    session[:previous_url] = request.referer
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "ログインしました"
      log_in(user)
      if session[:previous_url]
        redirect_to session[:previous_url]
      else
        redirect_to user_path(user)
      end
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
