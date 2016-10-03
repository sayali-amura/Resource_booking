require 'rails_helper'

RSpec.describe Employee, type: :model do
	subject {Employee.new()}
  it "is valid with valid attributes" do
  	subject.name = "anything"
  	subject.email = "www.vibha.com@foo.com"
  	subject.age = 10
  	subject.date_of_joining = Date.new
  	subject.manager_id = 0
  	subject.role_id = 1
  	subject.company_id = 20
  	expect(subject).to be_valid
  end
  describe "Associations" do
  it "has many bookings" do
    assc = Employee.reflect_on_association(:bookings)
    expect(assc.macro).to eq :has_many
  end

  it "has many complaints" do
    assc = Employee.reflect_on_association(:complaints)
    expect(assc.macro).to eq :has_many
  end
end



 end
