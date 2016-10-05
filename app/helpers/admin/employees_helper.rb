module Admin::EmployeesHelper
	def company_domain
		"   @"<<current_employee.company.name<<".com"
	end
	#listing roles present in company
	def list_roles
		roles = current_employee.company.roles
		@roles = []
		roles.each do | role |
			if role.designation!="admin"
				@roles << [role.designation, role.id]
			end
		end
	end
	#listing employees in company
	def list_employees
		employees = current_employee.company.employees
		@employees = []
		employees.each do | emp |
			@employees << [emp.name, emp.id]
		end
	end
	def role_name(role_id)
		name = current_employee.company.roles.find(role_id).designation
	end
	def employee_name(eid)
		name = current_employee.company.employees.find(eid).name
	end
end
