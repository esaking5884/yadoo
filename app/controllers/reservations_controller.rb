class ReservationsController < ApplicationController
  def new
    @inn_id = params[:id]
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @total_fee = (@reservation.inn.price * (@reservation.check_out - @reservation.check_in).to_i) * @reservation.number_of_people
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if params[:back].nil? && @reservation.save
      render "complete"
    else
      render "new"
    end
  end
end

private
def reservation_params
  params.require(:reservation).permit(:user_id, :inn_id, :number_of_people, :check_in, :check_out, :total_fee, :name)
end