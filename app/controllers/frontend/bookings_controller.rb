# -*- encoding : utf-8 -*-
class Frontend::BookingsController < Frontend::BaseController
  before_filter :authenticate_user
  before_filter :find_user

  def new
    if @user.bookings.count.zero?
      @hotels = Hotel.all
      @booking = Booking.new
    else
      redirect_to @user.bookings.first
    end
  end

  def create
    @hotels = Hotel.all
    if @user.bookings.count.zero? and @user.accepted?
      @booking = @user.bookings.new(booking_params)
      if @booking.save
        render 'create_successful'
      else
        render action: 'new'
      end
    else
      render 'already_booked'
    end
  end

  def show
    @booking = @user.bookings.find(params[:id])
  end

  protected
    def booking_params
      params.require(:booking).permit!
    end

    def find_user
      @user = User.find(session[:user_id])
    end
end