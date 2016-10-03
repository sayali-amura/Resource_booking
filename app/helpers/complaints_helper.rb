module ComplaintsHelper

	def status_normalization(status_code)
		case 
		when status_code == 0
			 "Pending"
		when status_code == 1
			 "Solved"
		end
	end
#returns resource name
	def resource_name(resource_id)
		@resource = current_employee.company.resources.find(resource_id)
		@resource.name
	end
end