module BookingsHelper

def status_normalization(status_code)
	case 
	when status_code == 0
		 "Request"
	when status_code == 1
		 "Grant"
	when status_code == 2
		 "Reject"
	when status_code == 3		
		 "Realease"
	end
end

end
