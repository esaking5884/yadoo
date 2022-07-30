class ApplicationController < ActionController::Base
  include SessionsHelper
  include InnsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:notice] = "ログインしてください"
      redirect_to login_url
    end
  end

  def kick_wrong_owner(inn)
    unless correct_owner?(inn)
      flash[:notice] = "権限がありません"
      redirect_to inn_path(params[:id])
    end
  end
  
  def kick_wrong_customer(reservation)
    unless correct_customer?(reservation)
      flash[:notice] = "権限がありません"
      redirect_to user_path(session[:user_id])
    end
  end
end
