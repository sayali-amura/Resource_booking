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

# def check_reply booking, status_code
# 	(!booking.reply.nil?) && (status_code==1 || status_code ==2)
# end

end
