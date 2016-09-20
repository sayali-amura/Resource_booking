class BookingsController < ApplicationController
	def index
		
	end
	def new
		
	end
	def create
		new_booking = Booking.create(booking_params)

	end

	protected
	def booking_params
		params.require[:booking].permit(:comment,:duration,:priority)
	end

end
