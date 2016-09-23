require 'rails_helper'


RSpec.describe Company, type: :model do
  before(:each) do 
    @company = Company.new(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:9.00,end_time: 6.00)
  end
  context "check Company table do" do 
    it "check empty object validation" do
      expect(Company.new).to_not be_valid
    end
  	it "check if Company table is empty" do
  		companies = Company.all
  		expect(companies.count).to eq(0)
  	end
  	it "check whether company count increments" do 
  		company = Company.create(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:9.00,end_time: 6.00)
  		expect(Company.all.count).to eq(1)
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

  context "check entry count" do 
    it "add entry to company" do 
      expect{@company.save}.to change(Company,:count).by(1)
    end
  end

end
