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

	def give_id(company_id)
	    resources = Resource.where(company_id:company_id)
	    @id_array = []
	    resources.each do |res|
	      @id_array << res.id 
	    end
	    @id_array
  	end

  	def humanize resource
  		# byebug
  		slot = resource.time_slot
  		hour = slot.strftime("%H")
  		minute = slot.strftime("%M")
  		"#{pluralize(hour.to_i, "Hour")}, #{pluralize(minute.to_i, "Minute")}"
  	end
end
