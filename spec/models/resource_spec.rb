require 'rails_helper'

RSpec.describe Resource, type: :model do
	before(:each) do 
		@company = create(:company)
    @resource = @company.resources.last
  end
  context "validations" do  
    it "must have time_slot" do
      @resource.time_slot = nil
      expect(@resource).to_not be_valid
    end
    context "name" do 
      it "unique across company" do
        @resource.name = "Same"
        @resource1 = Resource.new(name: "Same",time_slot: "67:90",company_id:1)
        expect(@resource1).to_not be_valid
      end
    end
  end

  context "instance methods" do 
    context "#available_time_slot" do
      it "date is today" do 
        @resource = @company.resources.first
        @employee = @company.employees.first
        @booking = build(:booking,comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-10-10', slot: 0,employee: @employee,resource: @resource)
        return_available_array = @resource.send :available_time_slot,@booking.date_of_booking.strftime("%Y%m%d")
        expect(return_available_array).to_not include(@resource.timeslots[0])
      end
      it "date is today" do 
        @resource = @company.resources.first
        @employee = @company.employees.first
         @booking = build(:booking,comment: "hello",feedback: "",employee_id:6,date_of_booking: '2017-10-10', slot: 0,employee: @employee,resource: @resource)
        return_available_array = @resource.send :available_time_slot,@booking.date_of_booking.strftime("%Y%m%d")
        expect(return_available_array).to include(@resource.timeslots[0])
      end
      it "same date" do 
        @resource = @company.resources.first
        @employee = @company.employees.first
        @booking = build(:booking,comment: "hello",feedback: "",employee_id:6,date_of_booking: '2017-10-10', slot: 0,employee: @employee,resource: @resource)
        @booking.status = 1
        @booking.save
        @booking = build(:booking,comment: "hello",feedback: "",employee_id:6,date_of_booking: '2017-10-10', slot: 0,employee: @employee,resource: @resource)
        return_available_array = @resource.send :available_time_slot,@booking.date_of_booking.strftime("%Y%m%d")
        expect(return_available_array).to_not include(@resource.timeslots[0])
      end
    end
  end

  context "Association" do 
    it "belongs to company" do 
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
    it "has many bookings" do
      assc = described_class.reflect_on_association(:bookings)
      expect(assc.macro).to eq :has_many
    end
    it "has many complaints" do
      assc = described_class.reflect_on_association(:complaints)
      expect(assc.macro).to eq :has_many
    end
  end
  context "time_slot method" do
    it "returns slot array string" do
      array = @resource.timeslots
      expect(array.sample.first).to be_kind_of(String)
    end
    it "returns slot array integer" do
      array = @resource.timeslots
      expect(array.sample.last).to be_kind_of(Integer)
    end
    it "has "
  end

end
