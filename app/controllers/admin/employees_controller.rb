class Admin::EmployeesController < ApplicationController
	before_action :find_employee, only: [:show, :edit, :update]
	before_action :find_company, only: [:index, :create, :dashbord,:change_status]
	before_action :find_complaints, only: [:index, :dashbord, :change_status]
	def index
		@bookings = @company.bookings.where("date_of_booking >= ?",Date.today)
		@employees = Employee.where(company_id:@company.id)
		
	end
	def new
		@employee = Employee.new
	end

	def create
		@employee = @company.employees.new(Employee.edited_employee( employee_params,@company ))
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

		@bookings = @company.bookings.where(status:0).where("date_of_booking >= ?",Date.today) if @company.bookings
		@complaints = @complaints.where(status:0) if @complaints
	end
	
	def change_status
		if(params[:status])
			booking = @company.bookings.find(params[:status][:booking_id])
			if params[:status][:status] =="Grant"
				booking.status = 1
			elsif params[:status][:status] == "Reject"
				booking.status = 2
			end
			if !booking.save
				flash[:alert] = "#{booking.errors.full_messages}"
			end
			redirect_to :admin_dashbord
		end
		if(params[:status_complaint])
			@complaints = find_complaints
			complaint = @complaints.find(params[:status_complaint][:complaint_id])
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
	def find_company
		@company = Company.find(current_employee.company_id)
	end
	def find_complaints
		give_id(current_employee.company_id)
		@complaints = Complaint.where(resource_id:@id_array)
	end
 
end

