class Admin::EmployeesController < ApplicationController
	before_action :find_employee, only: [:show, :edit, :update]
	def index
		@employees = Employee.all
		
	end
	def new
		@employee = Employee.new
	end

	def create
		dummy_employee = employee_params
		dummy_employee[:password] = "123456"
		dummy_employee[:email]<<"@#{current_employee.company.name}.com"
		@company = Company.find(current_employee.company_id)
		@employee = @company.employees.new(dummy_employee)
		if @employee.save
			redirect_to ["admin",@employee]
		else
			flash[:alert] = "#{@employee.errors.full_messages}"
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
		@complaints = Complaint.where(status:0)
	end
	
	def change_status
		if(params[:status])
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
		if(params[:status_complaint])
			complaint = Complaint.find(params[:status_complaint][:complaint_id])
			if params[:status_complaint][:status] == "Solve"
				complaint.status = 1
			end
			if complaint.save
			redirect_to :admin_dashbord
		end
		end
		
	end
	private
	def employee_params
		params.require(:employee).permit(:name, :email,:age, :date_of_joining, :role_id, :manager_id)
	end
	def find_employee
		@employee = current_employee
	end

 
end

