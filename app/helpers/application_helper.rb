module ApplicationHelper
	include Admin::ResourcesHelper
	def show_slot_time resource_id,slot_id
		resource = Resource.find(resource_id)
		time_slot_array =	resource.timeslots
		time_slot_array[slot_id].first
	end
end
