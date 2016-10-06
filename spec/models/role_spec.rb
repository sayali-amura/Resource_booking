require 'rails_helper'

RSpec.describe Role, type: :model do

  before(:each) do 
    @company = create(:company)
    @role = @company.roles.first
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

<<<<<<< HEAD
=======
  context "duplicate priority" do 
    it "priority" do 
      @role.save
      @role1 = @company.roles.build(designation: "coder",department: "development",priority: 3)
      @role1.save
      @company = Company.find(@company.id)
      # @company.reload
      p @company.roles.inspect
      @role2 = @company.roles[1]
      @role2.priority = 3
      # p @role2.errors
      expect(@role2.save).to eq(true)
      p @company.roles.inspect
>>>>>>> 6f621bac91073b3cf8f78704725bd4fd4931637c
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
  
#belongs_to :company
  # context "delete" do 
  #   it "delete role " do 
  #     @role.save
  #     @role.destroy
  #   end
  # end
  context "Asscociations" do 
    it "belongs to company" do 
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
    it "has many employees" do
      association = described_class.reflect_on_association(:employees)
    end
  end


end
