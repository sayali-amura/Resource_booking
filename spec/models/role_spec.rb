require 'rails_helper'

RSpec.describe Role, type: :model do

  before(:each) do 
    #@company = Company.create(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:Time.new(2016,3,1,9,0),end_time:Time.new(2016,3,1,18,0))
	 #@role = @company.roles.new(designation: "Admin",department: "Company",priority: 0,company_id:1 )
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


    end
  end
  
  # context "validation" do 
  #   context "repeat fields" do
  #     it "designation" do 
  #       @role.designation = "admin"
  #       @role.save
  #       @role2 = @company.roles[1]
  #       @role2.designation = "admin"
  #     end
  #     it "department" do 
  #       @role.department = "company"
  #       @role.save
  #       @role2 = @company.roles[1]
  #       @role2.department = "Company"
  #     end
  #     after(:each) do 
  #       expect(@role).to_not be_valid
  #     end
  #   end

  #   context "invalid fields" do 
  #     context "priority" do 
  #       it "less than 0" do
  #         @role.priority = -1
  #         expect(@role).to_not be_valid
  #       end
  #       it "alphabetics" do 
  #         @role.priority = "admin"
  #         expect(@role).to_not be_valid
  #       end
  #     end
  #   end

  #   context "valid fields" do 
  #     context "priority" do 
  #       it "greater than 0" do 
  #         @role.priority = 12
  #       end
  #     end
  #     after(:each) do 
  #       expect(@role2).to_not be_valid
  #     end
  #   end
  # end
#belongs_to :company
 # has_many :employees
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
