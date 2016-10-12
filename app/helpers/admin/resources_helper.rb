#
# Module Admin::ResourcesHelper provides resource time slot related helpers to use across controller and views
#
# @author Amrut Jadhav amrut@amuratech.com
#
module Admin::ResourcesHelper
	#
	# Function provides slots time text related to slot_id i.e "9:00-10:00" of resource. This method utilize the timeslots method 
	#   of Resource class. (see Resource#timeslots)
	# @param [Integer] resource_id Id of resource
	# @param [Integer] slot_id Id of resource slot
	#
	# @return [String] Slot correspoding to slot_id
	# 
	def show_slot_time resource_id,slot_id
		resource = Resource.find(resource_id)
		time_slot_array =	resource.timeslots
		time_slot_array[slot_id].first
	end
	#
	# Build resource [name,id] array. This array is used in the view to create select box for seleting resource.
	#   It find out resources of company using the current_emlpoyee helper provided by devise.
	#   For more info about current_employee refer this @see https://github.com/plataformatec/devise
	# @return [Array<String,Integer>] Resource array
	# 
	def resource_array
		resource = current_employee.company.resources.collect {|x|  [x.name.to_s,x.id] }
	end
#
  	#
  	# Function display resource timing in humanized format
  	#   @example Humanized format 
  	#   " 2000-01-01 01:00:00 UTC" #=> "1 Hour, 0 Minutes"
  	#
  	# @return [String] Humanized format of resource time slot
  	# 
  	def humanize resource
  		slot = resource.time_slot
  		hour = slot.strftime("%H")
  		minute = slot.strftime("%M")
  		"#{pluralize(hour.to_i, "Hour")}, #{pluralize(minute.to_i, "Minute")}"
  	end
end
