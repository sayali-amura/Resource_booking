#
# Class BookingsController provides CRUD operation and some methods for bookings
#
# @author Amrut Jadhav amrut@amuratech.com
#
class BookingsController < ApplicationController

	# Filters
	before_action :find_company

	# Authorize employee
	# @raise [CanCan::AccessDenied] if the user does not have permission
	load_and_authorize_resource :booking


	#
	# If company has resources display all future bookings of company 
	#
	#
	# @return [void] Initialize object if resource are available
	# 
	def index
		if @company.is_resource_available?
			@bookings = @company.bookings.where("date_of_booking >= ?",Date.today)
			@ongoing_bookings = Booking.ongoing_bookings(current_employee.company)
		end
	end

	#
	# Build booking object on company if resources are available
	#
	#
	# @return [void] Initialize object if resource are available
	# 
	def new
		if @company.is_resource_available?
			@booking = current_employee.bookings.build
			@resource = Resource.all
		end
	end

	#
	# Create new booking 
	# (see #booking_params)
	# 
	def create
		@booking = current_employee.bookings.build(booking_params)
		@booking.company_id = current_employee.company_id
		if  @booking.save
			flash[:success] = "Your booking is done"
			redirect_to bookings_path
		else
			render :new	
		end
	end

	#
	# Display booking of particular id
	# @param [Hash] params The params from get request
	# @option params [Integer] id Id of booking
	#
	# @return [Booking] Booking object
	# 
	def show
		@booking = @company.bookings.find(params[:id])
	end

	#
	# Edit booking 
	# @param [Hash] params The params from get request
	# @option params [Integer] id Id of booking
	#
	# @return [Booking] Booking object
	# 
	def edit
		@booking = @company.bookings.find(params[:id])
	end

	#
	# Update booking of particular id
	# (see #booking_params)
	# @option params [Integer] id Id of booking
	#
	# @return [void] redirect_to booking object if updation is successful else redirect to new
	# 
	def update
		@booking = @company.bookings.find(params[:id])
		if @booking.update_attributes(booking_params)
			flash[:success] = "Your booking is successfully updated"
			redirect_to @booking
		else
			flash[:success] = "Error while updating booking"
			render :edit
		end
	end

	#
	# Destroy booking of particular id
	# @param [Hash] params The params from delete request
	#
	# @return [void] redirect_to bookings index page.
	# 
	def destroy
		if @company.bookings.destroy(params[:id])
			flash[:success] = "Booking is successfully delted"
		else
			flash[:success] = "Error while deleting booking"
		end
			redirect_to bookings_path
	end
	
	#
	# This function is used to provide time slots of resource. Function is called by ajax request.
	#  It restuns all the available and non-available slots of resource
	# 
	def resource_time_slot
		@resource = @company.resources.find_by_name(params[:name])
	end

	#
	# This function is used to provide available time slots of resource of particular date. Function is called by ajax request.
	#
	#
	def booking_date_slots
		resource = @company.resources.find_by_name(params[:resource])
		@slot_array = resource.available_time_slot params[:date_of_booking]
	end

	private

	#
	# Allowing strong parameters
	# @param [Hash] params The params from post request	
	# @option params [String] comment Subject of booking
	# @option params [Integer] slot Slot id of booking
	# @option params [Date] date_of_booking Date of booking
	# @option params [Integer] resource Id of resource 
	#
	#
	# @return [Hash] Strong parameters hash
	# 
	def booking_params
		params.require(:booking).permit(:comment,:slot, :date_of_booking,:resource_id)
	end
	
end


