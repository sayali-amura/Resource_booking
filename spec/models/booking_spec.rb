require 'rails_helper'

RSpec.describe Booking, type: :model do

  before(:each) do 
  	@company = create(:company)
  	@resource = @company.resources.first
  	@employee = @company.employees.first
  	@booking = @employee.bookings.new({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-10-28', slot: 6})
  	@booking.resource_id = @resource.id
  end


  context "field validations" do 
  	context "date" do 
	  	it "previous date" do 
	  		@booking.date_of_booking = '2016-09-12'
	  		expect(@booking).to_not be_valid
	  	end
	  	it "empty date" do 
	  		@booking.date_of_booking = ""
	  		@booking.errors
	  		expect(@booking).to_not be_valid
	  	end
	  	it "holiday" do 
	  		@booking.date_of_booking = '2016-09-02'
	  		expect(@booking).to_not be_valid
	  	end
	end

	context "resource" do 
		it "empty resource" do 
			@booking.resource_id = ""
			expect(@booking).to_not be_valid
		end
	end

	context "slot" do 
		it "out of bound " do 
			@booking.slot = 12
			expect(@booking).to_not be_valid
		end
		it "float " do 
			@booking.slot = 1.500
			expect(@booking).to_not be_valid
		end
		it "same " do 
			@booking.save
			@booking = @employee.bookings.new({comment: "hello",feedback: "",date_of_booking: '2016-10-28', slot: 0})
			@booking.resource_id = @resource.id		
			expect(@booking).to_not be_valid	
		end
		it "passed " do 
			@booking.date_of_booking = "2016-10-03"
			@booking.slot = 0
			expect(@booking).to_not be_valid
		end
	end


  end

end
