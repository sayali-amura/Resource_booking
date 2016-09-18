class Employee::AdminController < ApplicationController
	def index
		@resources = Resource.all
		@bookings = Booking.all
	end
	def update_resources
	end



end
