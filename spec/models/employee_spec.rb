require 'rails_helper'

RSpec.describe Employee, type: :model do
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
