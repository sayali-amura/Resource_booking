require 'rails_helper'

RSpec.describe Resource, type: :model do
	before(:each) do 
		@resource = Resource.new(name: "Go",time_slot: "67:90",company_id:1)
	end
  context "validations" do 
  	context "time " do 
  		it "out of bound" do 
  			expect(@resource).to_not be_valid
  		end
  	end
    context "name" do 
      it "same across company" do 
        @resource.save
        @resource = Resource.new(name: "Go",time_slot: "67:90",company_id:1)
        expect(@resource).to_not be_valid
      end
    end
  end

  context "Association" do 
    it "belongs to company" do 
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
  end

end
