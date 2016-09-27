class BookingsController < ApplicationController
	# before_action :find_booking, only: [:show, :edit, :update]

	# include Admin::ResourcesHelper

	before_action :find_employee


	def index
		if @employee.company.is_resource_available?
			@bookings = @employee.company.bookings
		end
	end

	def new
		@booking = @employee.bookings.new
		if @employee.company.is_resource_available?
			@resource = Resource.find(params[:resource][:resource_id])
		end
	end

	def edit
		@booking = Booking.find(params[:id])
	end

	def create		
		@booking = @employee.bookings.new(booking_params)
		@booking.resource_id = params[:resource_id]
			if @booking.save
				flash[:success] = "Your booking is done"
				redirect_to @booking
			else
				render new_booking_path
			end
	end

	def show
		@booking = Booking.find(params[:id])
	end

	def update

		if @booking.update(booking_params)
			redirect_to @booking
		else
			render :edit
		end
	end

	def destroy
		Booking.destroy(params[:id])
		redirect_to bookings_path
	end

	private

	def booking_params
		params.require(:booking).permit(:comment,:slot,:priority, :date_of_booking)
	end
	
	def find_employee
		if employee_signed_in?
			@employee = current_employee
		else
			redirect_to root_path
		end
	end

end
