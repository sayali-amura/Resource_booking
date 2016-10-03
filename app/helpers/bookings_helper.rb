module BookingsHelper
#status translation to text from ids
def status_normalization1(status_code)
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

def resource_time_slot resource
	resource.timeslots
end




end
