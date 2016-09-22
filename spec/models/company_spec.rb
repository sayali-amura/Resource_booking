require 'rails_helper'

RSpec.describe Company, type: :model do
  context "check Company table do" do 
  	it "check if Company table is empty" do
  		companies = Company.all
  		expect(companies.count).to eq(0)
  	end
  	it "check whether company count increments" do 
  		company = Company.create(name: "hello1",email: "hello1@gmail.com",phone: "+911234567890",start_time:9.00,end_time: 6.00)
  		expect(Company.all.count).to eq(1)
  	end
  end

  context "company column datatype validation" do
	before(:context) do 
		@company = Company.new(name: "hello1",email: "hello1@gmail.com",phone: "+911234567890",start_time:9.00,end_time: 6.00)
	end
  	context "check phone column" do 
	  	it "validate phone regex" do
	  		@company.phone = "1234567890"
	  		expect(@company.save).to be false
	  	end
	  	if "validate phone datatype" do 
	  		expect(@company.save).to be_kind_of(String)
	  	end
 	end

 	context "check email column" do
 		it "correct email regex" do  
 			expect(@company.save).to be true
 		end 
 		it "incorrect email regex" do 
 			@company.email = "hello@"
 			expect(@company.save).to be false
 		end
 		it "variation of email" do 
 			@company.email = "123.www.amrut@gmail.com"
 			expect(@company.save).to be true
 		end
 		it "unexpected email input" do 
 			@company.email = "123.@hello@gmail.com.345"
 			expect(@company.save).to be false
 	end

  end
end
