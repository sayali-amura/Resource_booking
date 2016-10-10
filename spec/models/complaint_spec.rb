require 'rails_helper'

RSpec.describe Complaint, type: :model do
	before(:each) do 
		@company = create(:company)
    	@complaint = @company.complaints.last
	end
  	context "validations" do  
    	it "must have valid status" do
      		@complaint.status = 4
      		expect(@complaint).to_not be_valid
    	end
  		it "must have comment" do
    		@complaint.comment = nil
    		expect(@complaint).to_not be_valid
  		end
  		it "has integer resource id" do
  			@complaint.resource_id = nil
  			expect(@complaint.resource_id).not_to be_a_kind_of(Fixnum)
  		end
  		it "has integer employee id" do
  			@complaint.employee_id = nil
  			expect(@complaint.employee_id).not_to be_a_kind_of(Fixnum)
  		end
  	end

  	context "Association" do 
    	it "belongs to company" do 
      		assc = described_class.reflect_on_association(:company)
      		expect(assc.macro).to eq :belongs_to
    	end
    	it "belongs to resource" do
      		assc = described_class.reflect_on_association(:resource)
      		expect(assc.macro).to eq :belongs_to
    	end
    	it "belongs to employee" do
      		assc = described_class.reflect_on_association(:employee)
      		expect(assc.macro).to eq :belongs_to
    	end
  	end


end
