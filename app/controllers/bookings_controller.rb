class BookingsController < ApplicationController

	before_action :find_company, :verify_user
	skip_before_action :verify_user , only: [:index, :show]
	load_and_authorize_resource :booking
	def index
		if @company.is_resource_available?
			@bookings = @company.bookings
		end
	end

	def new
		if @company.is_resource_available?
			@booking = current_employee.bookings.new
			@resource = Resource.all
		else
			flash[:notice] = "No resources are available in your company"
		end
	end

	def resource_time_slot
		@resource = @company.resources.find_by_name(params[:name])
	end

	def booking_date_slots
		resource = @company.resources.find_by_name(params[:resource])
		@slot_array = resource.available_time_slot params[:date_of_booking]
	end
	def edit
		@booking = Booking.find(params[:id])
	end

	def create
		begin
			@booking = current_employee.bookings.new(booking_params)
			if  @booking.save
				flash[:success] = "Your booking is done"
				redirect_to @booking
			else
				render :new
			end
		rescue
			render :new
		end
	end

	def show
		@booking = Booking.find(params[:id])
	end

	def update
		@booking = Booking.find(params[:id])
		if @booking.update_attributes(booking_params)
			flash[:success] = "Your booking is successfully updated"
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
		params.require(:booking).permit(:comment,:slot,:priority, :date_of_booking,:resource_id)
	end
	
	def find_company
		if employee_signed_in? 
			@company = current_employee.company
		else
			redirect_to root_path
		end
	end

	def verify_user
		unless current_employee.id == session["warden.user.employee.key"][0][0]
			flash[:alert] = "You can't access other employees functionalities."
			redirect_to root_path
		end
	end

end
