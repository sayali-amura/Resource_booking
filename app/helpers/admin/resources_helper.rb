module Admin::ResourcesHelper


	def check_avability resource
		time_slot_array = resource.timeslots
		days_booking =	Booking.where("created_at >= ? and created_at<=?", Time.zone.now.beginning_of_day,Time.zone.now.end_of_day)
		puts "days_booking are #{days_booking.inspect}"
		if days_booking.any?
			days_booking.each{|x| time_slot_array.delete_at(x.slot) }
		end
		time_slot_array
	end

	def show_slot_time resource_id,slot_id
		resource = Resource.find(resource_id)
		time_slot_array =	resource.timeslots
		time_slot_array[slot_id].first
	end

	def available_time_slot resource,date_of_booking
		resource_slot = resource.timeslots
		if resource.bookings.where(date_of_booking:date_of_booking)
			bookings_of_day = resource.bookings.where(date_of_booking: date_of_booking)
			bookings_of_day.each do |x|
				resource_slot.delete_at(x.slot)
			end
			# byebug
		end
		# byebug
		resource_slot
	end



end
