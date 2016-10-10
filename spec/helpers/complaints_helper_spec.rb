require 'rails_helper'

RSpec.describe ComplaintsHelper, type: :helper do
	before(:each) do 
		@company = create(:company)
		@employee = @company.employees.first
  		@resource = @company.resources.first
	end
	context "#status_normalization" do 
	 	it "status_code is 0" do 
	 		expect(status_normalization(0)).to eq("Pending")
	 	end
	 	it "status_code is 1" do 
	 		expect(status_normalization(1)).to eq("Solved")
	 	end
	end
end
