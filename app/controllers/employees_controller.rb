class EmployeesController < ApplicationController

	before_action :find_employee

		# byebug
	def index
		if !employee_signed_in?
			redirect_to new_employee_session_path
		elsif current_employee.role_id ==0
			redirect_to admin_dashbord_path
		else
			@bookings = @employee.bookings
			@complaints = @employee.complaints
		end
	end

	

	private
	
	def find_employee
		if employee_signed_in?
			@employee = current_employee
		else
			redirect_to new_employee_session
		end
	end

end
