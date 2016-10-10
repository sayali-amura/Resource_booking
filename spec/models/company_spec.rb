require 'rails_helper'


RSpec.describe Company, type: :model do
  before(:each) do 
    @company = create(:company)
  end
  context "check methods" do 
    it "add two default role" do 
      expect(@company.roles.count).to eq(5)
    end
  end

  context "check presence" do 
    it "empty start_time" do 
      @company.start_time = ""
      expect(@company).to_not be_valid
    end
  end

  context "column datatype validation" do
  	context "check phone column" do 
	  	it "invalidate phone " do
	  		@company.phone = "1234567890"
	  		expect(@company).to_not be_valid
	  	end
	  	it "valid phone datatype" do 
	  		expect(@company).to be_valid
	  	end
 	  end

   	context "check email column" do
   		it "correct email regex" do  
   			expect(@company).to be_valid
   		end 
   		it "incorrect email regex" do 
   			@company.email = "hello@"
   			expect(@company).to_not be_valid
   		end
   		it "variation of email" do 
   			@company.email = "123.www.amrut@gmail.com"
   			expect(@company).to be_valid
   		end
   		it "unexpected email input" do 
   			@company.email = "123.@hello@gmail.com.345"
   			expect(@company).to_not be_valid
   	  end
    end
  end

  context "Associations" do 
    it "has many role" do 
      assc = described_class.reflect_on_association(:roles)
      expect(assc.macro).to eq :has_many
    end
    it "has many employee" do 
      assc = described_class.reflect_on_association(:employees)
      expect(assc.macro).to eq :has_many
    end
    it "has many resources" do 
      assc = described_class.reflect_on_association(:resources)
      expect(assc.macro).to eq :has_many
    end
    it "has many bookings" do 
      assc = described_class.reflect_on_association(:bookings)
      expect(assc.macro).to eq :has_many
    end
  end

end
