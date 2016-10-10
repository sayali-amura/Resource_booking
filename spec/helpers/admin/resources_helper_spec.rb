require 'rails_helper'

RSpec.describe Admin::ResourcesHelper, type: :helper do 
	before(:each) do 
	  	@company = create(:company)
	  	@resource = @company.resources.first
	  	# @employee = @company.employees.first
	  	# @booking = @employee.bookings.build({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-10-28', slot: 0})
	  	# @booking.resource_id = @resource.id
  	end

  	context "#humanize" do 
  		it "check humanize string" do 
  			slot = @resource.time_slot
  			hour = slot.strftime("%H")
  			minute = slot.strftime("%M")
  			result = "#{pluralize(hour.to_i, "Hour")}, #{pluralize(minute.to_i, "Minute")}"
  			expect(humanize(@resource)).to eq(result)
  		end
  	end
  	
  	context "#show_slot_time" do 
  		it "check first element timing" do 
	  		resource = @company.resources.first
	  		expect(show_slot_time(resource.id,0)).to eq(resource.timeslots[0][0])
	  	end
  	end

end