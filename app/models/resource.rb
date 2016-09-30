class Resource < ActiveRecord::Base


	belongs_to :company
	has_many :bookings
	has_many :complaints
	validates :time_slot, presence:true
	validates :name, presence: {message: "name should be present"}, uniqueness: { scope: :company_id,  message: "should have one per company" }

	def timeslots
		if (self != nil)
			company = self.company
			start_time = company.start_time
			end_time = company.end_time
			company_duration = (( end_time - start_time )/60).round(2)
			no_of_slots = ( company_duration / (self.time_slot.hour*60 + self.time_slot.min) ).to_i
			time_slot_array =Array.new
			remember_hour = start_time.hour.round
			remember_min = start_time.min
			no_of_slots.times do | index |
				#p "-------------------------#{time_slot_array}----------------------------------"
				a = remember_hour == 0 ? "00" : remember_hour
				b = remember_min == 0 ? "00" : remember_min
				c = ((remember_min + self.time_slot.min)/60 )+remember_hour+self.time_slot.hour == 0 ? "00" :((remember_min + self.time_slot.min)/60 )+remember_hour+self.time_slot.hour
				d = (remember_min + self.time_slot.min) % 60 == 0 ? "00" : (remember_min + self.time_slot.min) % 60
				time_slot_array << ["#{a}:#{b}-#{c}:#{d}", index]
				remember_hour = ((remember_min + self.time_slot.min)/60 )+remember_hour+self.time_slot.hour
				remember_min = (remember_min + self.time_slot.min) % 60
			end
			time_slot_array
		end
	end

	def available_time_slot date_of_booking
		resource_slot = self.timeslots
		if self.bookings.where(date_of_booking:date_of_booking)
			bookings_of_day = self.bookings.where(date_of_booking: date_of_booking)
			bookings_of_day.each do |x|
				resource_slot.delete_at(x.slot)
			end
		end
		resource_slot
	end
end
