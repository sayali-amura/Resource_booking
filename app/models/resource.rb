class Resource < ActiveRecord::Base


	belongs_to :company
	has_many :bookings
	has_many :complaints
	validates :count, numericality: { only_integer: true, greater_than: 0 }
	validates :name, :count, presence: true
	validates :name, uniqueness: { scope: :company_id,
    message: "should have one per company" }


	def timeslots
		company = self.company
		start_time = company.start_time
		end_time = company.end_time
		company_duration = end_time - start_time
		no_of_slots = ( company_duration / self.time_slot ).to_i
		time_slot_array =Array.new
		no_of_slots.times do | index |
			time_slot_array << ["#{index+start_time}-#{index+start_time+self.time_slot}", index]
		end
		time_slot_array
	end

	

end
