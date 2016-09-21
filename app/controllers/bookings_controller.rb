class BookingsController < ApplicationController
	# before_action :find_booking, only: [:show, :edit, :update]
	before_action :find_employee
	def index
		@bookings = Booking.all
	end

	def new
		@resource = Resource.find(params[:resource][:resource_id])
		@booking = Booking.new
	end

	def create		
		@booking = @employee.bookings.new(booking_params)
		@booking.resource_id = params[:resource_id]
		if @booking.save
			# render plain: "booking done"
			flash[:success] = "Your booking is done"
			redirect_to @booking
		else
			render new_booking_path
		end
		# render plain: params
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
		@employee = current_employee
	end

end
