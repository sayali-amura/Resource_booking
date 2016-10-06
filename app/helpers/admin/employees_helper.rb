#
# Module Admin provides helper methods related to employee functionalities
#
# @author Amrut Jadhav
#
module Admin::EmployeesHelper
	#
	# @deprecated This function is not more used
	# 
	def company_domain
		"@"<<current_employee.company.name<<".com"
	end
	#
	#
	# Function create roles array available in company. This array is used to create select box for selcting role
	#
	#
	# @return [Array<String,Integer>] @roles Array of roles
	# 
	def list_roles
		roles = current_employee.company.roles
		@roles = []
		roles.each do | role |
			if role.designation!="admin"
				@roles << [role.designation, role.id]
			end
		end
	end
	#
	#
	# Function lists employees in company
	#
	#
	# @return [Array<String,Integer>] @roles Array of employees
	# 
	def list_employees
		employees = current_employee.company.employees
		@employees = []
		employees.each do | emp |
			@employees << [emp.name, emp.id]
		end
	end
	#
	# Function provide role name corresponding to role_id		
	#
	# @param [Integer] role_id Role id
	#
	# @return [String] name Designation of employee
	# 
	def role_name role_id
		name = current_employee.company.roles.find(role_id).designation
	end
	#
	# Function provide role name corresponding to employee_id
	# @param [Integer] employee_id Employee id
	#
	# @return [String] name Name of employee
	# 
	def employee_name employee_id
		name = current_employee.company.employees.find(employee_id).name
	end
end
