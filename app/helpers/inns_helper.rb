module InnsHelper
  def correct_owner?(inn)
    inn.owner == session[:user_id]
  end

  def correct_customer?(reservation)
    reservation.user_id == session[:user_id]
  end
end