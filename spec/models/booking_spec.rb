require 'rails_helper'

RSpec.describe Booking, type: :model do
  before(:each) do 
  	@booking = Booking.new({comment: "hello",feedback: "",employee_id:6,date_of_booking: '2016-09-27',priority:0,company_id: 2, slot: 0,resource_id: 3})
  end
  context "field validations" do 
  	it "check is valid" do 
  		expect(@booking.save).to eq(true)
  	end
  end
end
