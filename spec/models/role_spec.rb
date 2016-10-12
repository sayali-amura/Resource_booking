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
      end
      it "is positive" do
        @role.priority = -1
        expect(@role).to_not be_valid
      end
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
        # p @company.roles.inspect
        @role.priority = 10001
        @role.save
        @role2 = @company.roles[2]
        @role2.priority = 10001
        expect(@role2).to_not be_valid
      end
    end
  end

  context "instance methods" do 
    context "#is_name_admin?" do 
      it "role is admin" do 
        @role = build(:role ,designation: "admin", department: "bolo", priority:2, company: @company)
        @role.send(:is_name_admin?)
        error_check "is_name_admin?", "to", "[Admin designation  => You can't assign the admin designation to anthoer employees]"
      end
      it "role is not admin" do 
         @role = build(:role ,designation: "other_than_admin", department: "check", priority:2, company: @company)
        @role.send(:is_name_admin?)
        error_check "is_name_admin?", "to_not", "=> You can't assign the admin designation to anthoer employees"
      end
    end
    context "#add_default_role " do 
      it "company has none role" do 
        @company.send(:add_empty_role)
        none_role_id = @company.roles.find_by_designation("none").id
        first_role = @company.roles[3]
        employee = create(:employee, manager_id: 4,role_id: first_role.id, company: @company)
        first_role.destroy
        employee.reload
        expect(employee.role_id).to eq(none_role_id)
      end
    end
    context "is_none_fields" do 
      it "add none role" do 
        @role = build(:role, designation: "none", company: @company)
        error_check "is_none_fields", "to", "=> You can't create none role"
      end
    end
    def error_check method,expectation, error_msg
        @role.send(method.to_sym)
        eval("expect(@role.errors.full_messages).#{expectation} include(/#{error_msg}/)")
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
    expect(@role.errors.messages.has_key?(:none)).to be true
  end
  it "check add_default_role" do
  end


end
