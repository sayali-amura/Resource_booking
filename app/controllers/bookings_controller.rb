class BookingsController < ApplicationController
	before_action :find_booking, only: [:show, :edit, :update]
	def index
		@bookings = Booking.all
	end

	def new
		@booking = Booking.new
	end

	def create
		@booking = Booking.new(booking_params)
		if @booking.save
			redirect_to @booking
		else
			render :new
		end
	end 

	def show
	 
	end
	def update 
		if @booking.update(booking_params)
			redirect_to @booking
		else
			render :edit
		end
	end
	private
	def booking_params
		params.require(:booking).permit(:duration, :status, :priority,
											 :feedback, :comment, :shift, :employee_id)
	end
	def find_booking
		@booking = Booking.find(params[:id])
	end

end
