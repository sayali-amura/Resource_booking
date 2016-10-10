require 'rails_helper'

RSpec.describe Booking, type: :model do

  before(:each) do 
  	@company = create(:company)
  	@resource = @company.resources.first
  	@employee = @company.employees.first
  	@booking = @employee.bookings.new({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-10-28', slot: 0})
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

  context "instance methods" do 
		context "positive" do 
			context "#is_resource_added_to_company" do 
				it "company has resource" do

					expect(@booking.send(:is_resource_added_to_company?)).to eq(true)
				end
				it "company don't have resource" do 
					@company.resources.destroy_all
					expect(@booking.send(:is_resource_added_to_company?)).to eq(false)
				end
			end
			context "#is_slot_already_passed?" do 
				it "date is today and slot is already passed  " do 
					@booking.date_of_booking = Date.today
					@booking.slot =  0
					error_check "is_slot_already_passed?", "to","=> This slot is already passed"
				end
				it "date is not today " do
					@booking.date_of_booking = Date.today+3
					@booking.slot = 0
					@booking.send(:is_slot_already_passed?)
					expect(@booking.errors.any?).to eq(false)
				end
			end
			context "#check_holiday?" do 
				it "date_of_booking is holiday" do 
					@booking.date_of_booking = "2016-10-16"
					error_check "check_holiday?", "to","=> Booking can't be done on holidays"
				end
				it "date_of_booking is not holiday" do 
					@booking.date_of_booking = Date.today
					error_check "check_holiday?", "to_not", "=> Booking can't be done on holidays"
				end
			end
			context "#slot_valid?" do
				it "booking slot is present in resource timeslots" do 
					error_check "slot_valid?","to_not", "=> This slot is invalid" 
				end
				it "booking slot is not present in resource timeslots" do 
					@booking.slot = -9
					error_check "slot_valid?","to", "=> This slot is invalid"
				end
			end
			context "#is_date_valid?" do 
				it "past date" do 
					@booking.date_of_booking = "2016-03-13"
					error_check "is_date_valid?", "to", "=> You can't book resource for previous day"
				end
				it "future date" do 
					@booking.date_of_booking = "2016-12-13"
					error_check "is_date_valid?", "to_not", "=> You can't book resource for previous day"
				end
			end
			context "#is_slot_alloted?" do 
				it "no bookings" do 
					error_check "is_slot_alloted?","to_not","=> This slot is already alloted"
				end
				it "new record with different slot" do 
					@booking.save
					@booking = @employee.bookings.build({comment: "hello",feedback: "",employee_id:6,date_of_booking: "2016-10-28", slot: 1})
					error_check "is_slot_alloted?","to_not","=> This slot is already alloted"
				end
				it "old record with different slot" do 
					@booking.save
					@booking.slot = 1
					error_check "is_slot_alloted?", "to_not","=> This slot is already alloted"
				end
				it "old record but same slot" do 
					@booking.save
					@booking.slot = 0
					error_check "is_slot_alloted?", "to_not","=> This slot is already alloted"
				end
				it "new record but already alloted slot" do
					@booking.save
					@booking = @employee.bookings.build({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-10-28', slot: 0})
  					@booking.resource_id = @resource.id
  					error_check "is_slot_alloted?","to","=> This slot is already alloted"
				end
			end
			def error_check method,expectation, error_msg
				@booking.send(method.to_sym)
				eval("expect(@booking.errors.full_messages).#{expectation} include(/#{error_msg}/)")
			end
			def print_all
				p @company.inspect
				p "employee are #{@company.employees.inspect}"
				p "resources are #{@company.resources.inspect}"
				p "bookings are #{@company.bookings.inspect}"
			end
		end
	end

end
