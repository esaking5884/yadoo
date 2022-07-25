module InnsHelper
  def correct_owner?(inn)
    inn.owner == session[:user_id]
  end
end
