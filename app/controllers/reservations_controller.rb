class ReservationsController < ApplicationController
  before_action :logged_in_user, only:[:new, :confirm, :edit, :edit_confirm, :update, :destroy]

  def new
    @inn = Inn.find(params[:inn_id])
    @reservation = Reservation.new
  end
  
  def confirm
    @reservation = Reservation.new(reservation_params)
    if @reservation.valid?
      if @reservation.valid?(:valid_date)
        @total_fee = (@reservation.inn.price * (@reservation.check_out - @reservation.check_in).to_i) * @reservation.number_of_people
      else
        render "new"
      end
    else
      render "new"
    end
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if params[:back].nil? && @reservation.save
      render "complete"
    else
      render "new"
    end
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
    kick_wrong_customer(@reservation)
  end
  
  def edit_confirm
    @reservation = Reservation.find(params[:reservation][:id])
    @reservation.attributes = reservation_params
    kick_wrong_customer(@reservation)
    if @reservation.valid?
      if @reservation.valid?(:valid_date)
        @total_fee = (@reservation.inn.price * (@reservation.check_out - @reservation.check_in).to_i) * @reservation.number_of_people
      else
        render "edit"
      end
    else
      render "edit"
    end
  end
  
  def update
    @reservation = Reservation.find(params[:reservation][:id])
    kick_wrong_customer(@reservation)
    if @reservation.update(reservation_params)
      flash[:notice] = "予約を変更しました"
      redirect_to user_path(session[:user_id])
    else
      render "edit"
    end
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    kick_wrong_customer(@reservation)
    flash[:notice] = "キャンセルしました"
    @reservation.destroy
    redirect_to user_path(session[:user_id])
  end
end

private
def reservation_params
  params.require(:reservation).permit(:user_id, :inn_id, :number_of_people, :check_in, :check_out, :total_fee, :name)
end