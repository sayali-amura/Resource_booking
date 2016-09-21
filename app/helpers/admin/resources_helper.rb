module Admin::ResourcesHelper
	def timeslots(resource)
		company = Company.find(resource.company_id)
		start_time = company.start_time
		end_time = company.end_time
		company_duration = end_time - start_time
		no_of_slots = ( company_duration / resource.time_slot ).to_i
		time_slot_array =Array.new
		no_of_slots.times do | index | 
			time_slot_array << ["#{index+start_time}-#{index+start_time+resource.time_slot}", index]
		end
		time_slot_array
	end


	def check_avability resource
		time_slot_array = timeslots resource
		days_booking =	Booking.where("created_at >= ?", Time.zone.now.beginning_of_day)
		if !days_booking.nil?
			days_booking.each{|x| time_slot_array.delete_at(x.slot) }
		end
		time_slot_array
	end

	def show_slot_time resource_id,slot_id
		resource = Resource.find(resource_id)
		time_slot_array =	timeslots resource
		time_slot_array[slot_id].first
	end

end
