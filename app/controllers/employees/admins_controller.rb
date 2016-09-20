class Employees::AdminsController < ApplicationController
	before_action :find_employee, only: [:show, :edit, :update]
	def index
		@employees = Employee.all
	end
	def new
		@employee = employee.new
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
	def update 
		if @employee.update(employee_params)
			redirect_to @employee
		else
			render :edit
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
