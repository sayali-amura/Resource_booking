require 'rails_helper'

RSpec.describe Booking, type: :model do

  before(:each) do 
  	@company = Company.create(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:9.00,end_time: 18.00)
  	@resource = @company.resources.create(name: "ac", count: 1,time_slot:1.00)
  	@role = @company.roles.create(designation: "developer",department: "code",priority: 3)
  	
  	@employee = @company.employees.new(email: "a@gmail.com",name: "amrut",age: 23, manager_id: 2,date_of_joining:"2016-09-26")
  	@employee.role_id = @role.id
  	@employee.save

  	@booking = @employee.bookings.new({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-09-28',priority:0, slot: 0})
  	@booking.resource_id = @resource.id
  end


  context "field validations" do 
  	context "date" do 
	  	it "previous date" do 
	  		@booking.date_of_booking = '2016-09-12'
	  		expect(@booking).to_not be_valid
	  	end
	  	it "future date" do
	  		expect(@booking).to be_valid
	  	end
	  	it "holiday" do 
	  		@booking.date_of_booking = '2016-09-02'
	  		expect(@booking).to_not be_valid
	  	end
	end

	context "slot" do 
		it "out of bound slot" do 
			@booking.slot = 12
			expect(@booking).to_not be_valid
		end
		it "float slot" do 
			@booking.slot = 1.500
			expect(@booking).to be_valid
		end
		it "same slot" do 
			@booking.save
			@booking = @employee.bookings.new({comment: "hello",feedback: "",date_of_booking: '2016-09-28',priority:0, slot: 0})
			@booking.resource_id = @resource.id		
			expect(@booking).to_not be_valid	
		end
	end

	context "resource" do 
		it "invalid resource" do 
			@booking.resource_id = 8999999999
			expect{@booking}.to raise_error
		end

	end


  end

end
