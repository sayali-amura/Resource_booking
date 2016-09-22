module ComplaintsHelper
def build_resourcelist
	@resources = Resource.all
	@arr = []
	@resources.each do |res|
	@arr << [res.name,res.id]
	end
	@arr
end
def status_normalization(status_code)
	case 
	when status_code == 0
		 "Pending"
	when status_code == 1
		 "Solved"
	end
end
end
