class EmployeesController < ApplicationController

	# find out current employee
	before_action :find_employee

	# Authorize employee
	# @raise [CanCan::AccessDenied] if the user does not have permission
	load_and_authorize_resource :employee

	#
	# This method is root path of application. This method checks whether current_employee is admin or  
	#   he is just a regular employee. If designation of current_employee is admin then he will be 
	#   redirect_to admin_dashbord else he will stay here and booking, complaints object will be set
	# @return redirect to admin_dashbord if he is admin else intialize @booking to all future bookings 
	#    and @complaints to all complaints in his company 
	def entry
		@company =current_employee.company
      	admin_role_id = @company.roles.find_by(designation: "admin").id
		if current_employee.role_id == admin_role_id 
			redirect_to admin_dashbord_path
		end
			@bookings = @employee.bookings.where(:date_of_booking.gte => Date.today)
			@complaints = @employee.complaints
	end

end
