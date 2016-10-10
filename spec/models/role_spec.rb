require 'rails_helper'

RSpec.describe Role, type: :model do

  before(:each) do 
    @company = create(:company)
    @role = @company.roles[3]
  end

  context "validations" do
    context "check presence true" do 
      
      it "is not valid without designation" do
        @role.designation = nil
        expect(@role).to_not be_valid
      end
      it "is not valid without department" do
        @role.department = nil
        expect(@role).to_not be_valid
      end

    end

    context "priority validations" do
      
      it "s priority is integer" do
        @role.priority = "hello"
        expect(@role).to_not be_valid
      end
      it "is not zero" do
        @role.priority = 0
        expect(@role).to_not be_valid
      end
      it "is less than or equal to 2147483647" do
        @role.priority = 2147483648
        expect(@role).to_not be_valid
<<<<<<< HEAD
      end
      it "is positive" do
        @role.priority = -1
        expect(@role).to_not be_valid
      end
=======
      end
      it "is positive" do
        @role.priority = -1
        expect(@role).to_not be_valid
      end
>>>>>>> 7100172608f0c8c0cc887e121430000c55ad5f3a
      it "is not admin" do
        @role.designation = "admin"
        expect(@role).to_not be_valid
      end
    end
    context "designation validations" do
      it "has designation unique accross company's department" do
        @role.designation = "developer"
        @role.department = "sell.do"
        @role.save
        @role2 = @company.roles[1]
        @role2.designation = "developer"
        @role2.department = "sell.do"
        expect(@role2).to_not be_valid
      end
    end
    context "priority validations" do
      it "has priority unique accross company" do
        @role = @company.roles[3]
        @role.priority = 10001
        @role.save
        @role2 = @company.roles[2]
        @role2.priority = 10001
        expect(@role2).to_not be_valid
      end
    end

  end
  
  context "Asscociations" do 
    it "belongs to company" do 
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
    it "has many employees" do
      association = described_class.reflect_on_association(:employees)
    end
  end
  it "checks name validity not admin" do
    @role.designation = "admin"
    a = @role.save
    expect(@role.errors.messages.has_key?(:admin_designation)).to be true
  end
  it "checks name validity not none" do
    @role.designation = "none"
    a = @role.save
    byebug
    expect(@role.errors.messages.has_key?(:none)).to be true
  end
  it "check add_default_role" do
  end


end
