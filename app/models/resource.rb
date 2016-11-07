#
# Class Resource provides company's resource related functionality			
# 
# @author Amrut Jadhav amrut@amuratech.com
#
class Resource

	# include mongoid dependancies
	include Mongoid::Document
	include Mongoid::Timestamps

	# specify modle fields
	field 	:created_at, type: DateTime
	field 	:updated_at, type: DateTime
	field 	:name, type: String
	field 	:company_id, type: BSON::ObjectId
	field 	:time_slot, type: Time

	# define index
	index({company_id: 1})

	# Association
	belongs_to :company
	has_many :bookings, dependent: :destroy
	has_many :complaints, dependent: :destroy

	# Validations
	validates :time_slot, presence:true
	validates :name, presence: {message: "name should be present"}, uniqueness: { scope: :company_id,  message: "should have one per company" }

	#
	# Provide array of all timeslots available in the company's timing based upon the resource time_slot and
	#   companies start_time, end_time		
	#
	# @return [Array<String,Integer>] time_slot_array Array of time slots of resource 
	# 
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

	#
	# Provide future available time slots for resource. 
	#   If date of booking is today provide today's available time slots (see #next_time_slots)	
	#
	# @return [Array<String,Integer>] time_slot_array Array of available time slots of resource 
	# 
	def available_time_slot date_of_booking
		if date_of_booking.gsub(/[-]+/,"").to_i != Time.zone.now.strftime("%Y%m%d").to_i
			resource_slot = self.timeslots
			if self.bookings.where(date_of_booking:date_of_booking).where(status:1)
				bookings_of_day = self.bookings.where(date_of_booking: date_of_booking).where(status:1)
				bookings_of_day.each do |x|
					resource_slot.delete_at(x.slot)
				end
			end
		else
			resource_slot = next_time_slots
		end
		resource_slot
	end

	#
	# Provide array of today's available time slots 
	#
	#
	# @return [Array<String,Integer>] time_slot_array Array of today's available time slots of resource 
	# 
	def next_time_slots
		time_slot_array = self.timeslots
		time_slot_array.drop_while do |x|
			x[0].split("-")[0].to_time < Time.now
		end
	end

end
