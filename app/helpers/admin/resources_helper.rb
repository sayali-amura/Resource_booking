module Admin::ResourcesHelper
#returns slot time text from slot id
	def show_slot_time resource_id,slot_id
		resource = Resource.find(resource_id)
		time_slot_array =	resource.timeslots
		time_slot_array[slot_id].first
	end
#build resource [name,id] array
	def resource_array
	resource = current_employee.company.resources.collect {|x|  [x.name.to_s,x.id] }
	end
#display resource timing in format
  	def humanize resource
  		slot = resource.time_slot
  		hour = slot.strftime("%H")
  		minute = slot.strftime("%M")
  		"#{pluralize(hour.to_i, "Hour")}, #{pluralize(minute.to_i, "Minute")}"
  	end

  	def resource_array
		resource = current_employee.company.resources.collect {|x|  [x.name.to_s,x.id] }
	end

end
