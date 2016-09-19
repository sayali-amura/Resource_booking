class Employees::HomesController < ApplicationController
	def index
		if !employee_signed_in?
			redirect_to new_employee_session_path
		elsif current_employee.role_id ==3
			redirect_to employees_admins_path
		end
	end


	
	
end
