require 'rails_helper'

RSpec.describe BookingsHelper, type: :helper do
	before(:each) do 
		@company = create(:company)
		@employee = @company.employees.first
  		@resource = @company.resources.first
	end
	context "#status_normalization" do 
	 	it "status_code is 0" do 
	 		expect(status_normalization1(0)).to eq("Pending")
	 	end
	 	it "status_code is 1" do 
	 		expect(status_normalization1(1)).to eq("Grant")
	 	end
	 	it "status_code is 2" do 
	 		expect(status_normalization1(2)).to eq("Reject")
	 	end
	 	it "status_code is 3" do 
	 		expect(status_normalization1(3)).to eq("Realease")
	 	end
	end
	context "#resource_time_slot" do
		it "check if result is array" do 
			expect(resource_time_slot(@resource).class).to eq(Array)
		end
		it "check whther array contain first entry" do 
			expect(resource_time_slot(@resource)).to include(@resource.timeslots[0])
		end
	end
end
