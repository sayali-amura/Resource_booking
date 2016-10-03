module Admin::EmployeesHelper
	def company_domain
		"   @"<<current_employee.company.name<<".com"
	end
	def list_roles
		roles = current_employee.company.roles
		@roles = []
		roles.each do | role |
			if role.designation!="Admin"
				@roles << [role.designation, role.id]
			end
		end
	end
	def list_employees
		employees = current_employee.company.employees
		@employees = []
		employees.each do | emp |
			@employees << [emp.name, emp.id]
		end
	end
end
