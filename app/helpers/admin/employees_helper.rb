module Admin::EmployeesHelper
	def company_domain
		"   @"<<current_employee.company.name<<".com"
	end
end
