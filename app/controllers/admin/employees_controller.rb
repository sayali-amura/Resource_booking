class Admin::EmployeesController < ApplicationController
	before_action :find_company
	before_action :find_another_employee, only: [:show,:edit, :update]
	before_action :find_complaints, only: [ :dashbord, :change_status]

	def index
		@employees = @company.employees
	end
	def new
		@employee = Employee.new
	end

	def create
		@employee = @company.employees.build(employee_params)
		@employee.skip_password_validation = true
		if @employee.save
			redirect_to admin_employees_path
		else
			render :new
		end
	end 

	def show
		redirect_to admin_employees_path
	end

	def edit;	end
	
	def update 
		@employee.skip_password_validation = true
			if @employee.update_attributes(employee_params)
				redirect_to admin_employees_path
			else
				render :edit
			end
	end

	def destroy
		@admin = @company.employees.find_by(name:"admin")
		if @company.employees.destroy(params[:id])
			flash[:success] = "Employee and his bookings and complaints are succeesfully deleted"
			@company.employees.where(manager_id:params[:id]).each do | record_emp |
				record_emp.manager_id = @admin.id
				record_emp.skip_password_validation = true
				record_emp.save
			end
		else
			flash[:danger] = "Error while deleting employee"
		end
		redirect_to admin_employees_path
	end
	
	def dashbord
		if @company.resources.any?
			@bookings = @company.bookings.where(status:0).where("date_of_booking >= ?",Date.today) if @company.bookings
			@complaints = @complaints.where(status:0) if @complaints
		end
	end

	def change_status
		if(params[:status])	
			flag = 0	
			booking = @company.bookings.find(params[:status][:booking_id])
			if params[:commit] =="Grant"
				booking.status = 1
			elsif params[:commit] == "Reject"
				flag = 1
				booking.status = 2
			end
			if flag == 1
				booking.save(validate:false)
			elsif !booking.save
				flash[:alert] = "#{booking.errors.full_messages}"
			end
			redirect_to :admin_dashbord
		end
		if(params[:status_complaint])
			complaint = @complaints.find(params[:status_complaint][:complaint_id])
			if params[:commit] == "Solve"
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
	
	def find_complaints
		@complaints = @company.complaints
	end
	
	def find_another_employee
		@employee = @company.employees.find(params[:id])
	end
end

