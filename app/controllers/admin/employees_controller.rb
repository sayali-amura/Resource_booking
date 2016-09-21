class Admin::EmployeesController < ApplicationController
	layout "adminlayout"
	before_action :find_employee, only: [:show, :edit, :update]
	def index
		@employees = Employee.all
		
	end
	def new
		@employee = Employee.new
	end

	def create
		@employee = employee.new(employee_params)
		if @employee.save
			redirect_to @employee
		else
			render :new
		end
	end 

	def show
	 
	end
	def edit
	end
	def update 
		if @employee.update(employee_params)
			redirect_to ["admin",@employee]
		else
			render :edit
		end
	end
	def dashbord
		@bookings = Booking.where(status:0)
	end
	def change_status
		booking = Booking.find(params[:status][:booking_id])
		if params[:status][:status] =="Grant"
			booking.status = 1
	elsif params[:status][:status] == "Reject"
			booking.status = 2
	end	
		if booking.save
			redirect_to :admin_dashbord
		end
	end
	private
	def employee_params
		params.require(:employee).permit(:name, :email, :password_digest, :date_of_joining, :role_id, :manager_id)
	end
	def find_employee
		@employee = Employee.find(params[:id])
	end

 
end

