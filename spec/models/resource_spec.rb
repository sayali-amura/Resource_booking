require 'rails_helper'

RSpec.describe Resource, type: :model do
	before(:each) do 
		@resource = Resource.new(name: "Go",count: 3,time_slot: "67:90",company_id:1)
	end
  context "validations" do 
  	context "time " do 
  		it "out of bound" do 
  			expect(@resource).to_not be_valid
  			puts @resource.inspect
  		end
  	end
  end

end
