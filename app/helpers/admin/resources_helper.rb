module Admin::ResourcesHelper
	def timeslots(resource)
		company = Company.find(resource.company_id)
		@start_time = company.start_time
		@end_time = company.end_time
		company_duration = @end_time - @start_time
		no_of_slots = ( company_duration / resource.time_slot ).to_i
		@array =Array.new
		no_of_slots.times do | index | 
			@array << "#{index+@start_time}-#{index+@start_time+resource.time_slot}"
		end
		@array
	end

end
