class EmployeesController < ApplicationController

	before_action :find_employee

	def index
		if !employee_signed_in?
			redirect_to new_employee_session_path
		elsif current_employee.role_id ==0
			redirect_to admin_dashbord_path
		end
		@bookings = @employee.bookings
		@complaints = @employee.complaints
	end

	

	private
	def find_employee
		if employee_signed_in?
			@employee = current_employee
		else
			redirect_to root_path
		end
	end

end
