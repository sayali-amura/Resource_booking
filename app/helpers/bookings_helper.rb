module BookingsHelper

def status_normalization(status_code)
	case 
	when status_code == 0
		 "Pending"
	when status_code == 1
		 "Grant"
	when status_code == 2
		 "Reject"
	when status_code == 3		
		 "Realease"
	end
end
def priority_normalization(priority_code)
	case 
	when priority_code == 0
		 "Low"
	when priority_code == 1
		 "Medium"
	when priority_code == 2
		 "High"
	end
end

def resource_array
	resource = current_employee.company.resources.collect {|x|  [x.name.to_s,x.id] }
end

def resource_time_slot resource
	check_avability resource
end




end
