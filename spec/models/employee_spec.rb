require 'rails_helper'

RSpec.describe Employee, type: :model do
	# subject {Employee.new()}
 #  it "is valid with valid attributes" do
 #  	subject.name = "anything"
 #  	subject.email = "www.vibha.com@foo.com"
 #  	subject.age = 10
 #  	subject.date_of_joining = Date.new
 #  	subject.manager_id = 0
 #  	subject.role_id = 1
 #  	subject.company_id = 20
 #  	expect(subject).to be_valid
 #  end
 #  describe "Associations" do
 #  it "has many bookings" do
 #    assc = Employee.reflect_on_association(:bookings)
 #    expect(assc.macro).to eq :has_many
 #  end

 #  it "has many complaints" do
 #    assc = Employee.reflect_on_association(:complaints)
 #    expect(assc.macro).to eq :has_many
 #  end
 #  it "returns Employee's all bookings"

  before(:each) do 
  	@employee = Employee.new(name: "Admin",email: "admin@amura.com",age:22,date_of_joining: Date.today,manager_id: 0, company_id: 1)
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
end



 end
