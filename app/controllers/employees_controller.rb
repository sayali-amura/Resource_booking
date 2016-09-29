class EmployeesController < ApplicationController

	before_action :find_employee

	load_and_authorize_resource :employee
	skip_authorize_resource :only => :index

	def entry

		if !employee_signed_in?
			redirect_to new_employee_session_path
		elsif @employee.role_id == admin_role_id
			redirect_to admin_dashbord_path
		end
			@bookings = @employee.bookings
			@complaints = @employee.complaints
	end

	def admin_role_id
		company = @employee.company
      	company.roles.find_by_designation("Admin").id
	end

	private
	
	def find_employee
		if employee_signed_in?
			@employee = current_employee
		else
			redirect_to new_employee_session_path
		end
	end

end
