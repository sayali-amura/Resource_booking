class BookingsController < ApplicationController
	before_action :find_booking, only: [:show, :edit, :update]
	def index
		@bookings = Booking.all
	end

	def new
		@booking = Booking.new
	end

	def create

		new_booking = Booking.create(booking_params)

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

		params.require[:booking].permit(:comment,:duration,:priority)
	end

end
