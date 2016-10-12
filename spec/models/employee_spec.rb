require 'rails_helper'

RSpec.describe Employee, type: :model do

  before(:each) do 
  	#@employee = Employee.new(name: "Admin",email: "admin@amura.com",age:22,date_of_joining: Date.today,manager_id: 0, company_id: 1)
    @company = create(:company)
    @employee = @company.employees[3]
  end
  context "Associations" do 
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
	it "belongs to role" do 
	  	assc = described_class.reflect_on_association(:role)
	    expect(assc.macro).to eq :belongs_to
	end	

  end
  context "validations" do 
  	it "has to have name" do 
  		@employee.name = nil
  		expect(@employee).to_not be_valid
  	end
  	it "has to have email" do 
  		@employee.email = nil
  		expect(@employee).to be_invalid
  	end
  	it "has to have age" do 
  		@employee.age = nil
  		expect(@employee).to be_invalid
  	end
  	it "has to have role_id" do 
  		@employee.role_id = nil
  		expect(@employee).to be_invalid
  	end
  	it "has to have manager_id" do 
  		@employee.manager_id = nil
  		expect(@employee).to be_invalid
  	end
  	it "has to have date_of_joining" do 
  		@employee.date_of_joining = nil
  		expect(@employee).to be_invalid
  	end
  	it "has integer age" do
  		@employee.age = "abcd"
  		expect(@employee).to_not be_valid 
  	end
    it "has positive age" do
      @employee.age = -2
      expect(@employee).to_not be_valid
    end
  	it "has integer value for role_id" do
  		@employee.role_id = "aaa"
  		expect(@employee).to_not be_valid 
  	end
  	it "has integer value for manager_id" do
  		@employee.manager_id = "abcd"
  		expect(@employee.manager_id.class).to_not be(Integer) 
  	end
  	it "has valid email format" do
  		@employee.email = "hello @foo"
  		expect(@employee.email).to_not match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  	end

  	it "is expected to be an Employee" do 
  		expect(@employee).to be_an_instance_of(Employee)
  	end
  end
    it "returns correct manager" do 
      manager = Employee.find(@employee.manager_id)
      expect(@employee.manager).to eq(manager)
    end
    it "returns subordinates" do
      subordinates = Employee.where(manager_id:@employee.id)
      expect(@employee.subordinates).to eq(subordinates) 
    end
    it "lowers email content" do
      @employee.email = "sayali@GMAIL.com"
      @employee.skip_password_validation = true
      employee.save
      expect(@employee.email).to eq("sayali@gmail.com")
    end
    it "lowers name" do
      @employee.name = "SAYALIp"
      @employee.skip_password_validation = true
      @employee.save
      expect(@employee.name).to eq("sayalip")
    end
end

