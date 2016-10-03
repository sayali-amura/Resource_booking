module ComplaintsHelper

	def status_normalization(status_code)
		case 
		when status_code == 0
			 "Pending"
		when status_code == 1
			 "Solved"
		end
	end
	
	def resource_name(resource_id)
		@resource = Resource.find(resource_id)
		@resource.name
	end
	
	# def give_id(company_id)
	# 	resources = Resource.where(company_id:company_id)
	# 	@id_array = []
	# 	resources.each do |res|
	# 		@id_array << res.id 
	# 	end
	# 	@id_array
	# end

end