class Employee::AdminControllerController < ApplicationController
	def index
		@bookings = Bookings.all
	end
	def create
	end
	def show
	end

end
