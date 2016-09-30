class EmployeesController < ApplicationController

	before_action :find_employee
	load_and_authorize_resource :employee
	#load_and_authorize_resource :complaint
	skip_authorize_resource :only => :index

	def entry
		@company =current_employee.company
      	admin_role_id = @company.roles.find_by_designation("Admin").id
		# if !employee_signed_in?
		# 	redirect_to new_employee_session_path
		# elsif current_employee.role_id == admin_role_id 
		if current_employee.role_id == admin_role_id 
			redirect_to admin_dashbord_path
		else
			@bookings = @employee.bookings
			@complaints = @employee.complaints
		end
	end

end
