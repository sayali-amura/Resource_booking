class EmployeesController < ApplicationController
	def index
		if !employee_signed_in?
			redirect_to new_employee_session_path
		elsif current_employee.role_id ==0
			redirect_to admin_employees_path
		end
	end
end
