class BookingsController < ApplicationController
	# before_action :find_booking, only: [:show, :edit, :update]

	# include Admin::ResourcesHelper

	before_action :find_company


	def index
		if @company.is_resource_available?
			@bookings = @company.bookings
		end
	end

	def new
		if @company.is_resource_available?
			@booking = current_employee.bookings.new
			@resource = Resource.all
		end
	end


	def resource_time_slot
		@resource = @company.resources.find_by_name(params[:name])
	end

	def booking_date_slots
		resource = @company.resources.find_by_name(params[:resource])
		@slot_array = available_time_slot(resource,params[:date_of_booking])
	end

	def edit
		@booking = Booking.find(params[:id])
	end

	def create		
		@booking = current_employee.bookings.new(booking_params)
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
	
	def find_company
		if employee_signed_in?
			@company = current_employee.company
		else
			redirect_to root_path
		end
	end

end
