class BookingsController < ApplicationController
	def index
		
	end
	def new
		
	end
	def create
		new_booking = Booking.new(booking_params)
		new_booking = 
	end

	protected
	def booking_params
		params.require[:booking],permit(:comment,:duration,:priority)
	end

end
