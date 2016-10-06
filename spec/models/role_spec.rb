require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) do 
    @company = Company.create(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:"9:00",end_time: "18:00")
    # p @company.errors
	 @role = @company.roles.build(designation: "Admin",department: "Company",priority: 2)
  end

  context "validation" do 
    context "repeat fields" do
      it "admin " do 
        @role.save
        @role = Role.new(designation: "Admin",department: "Company",priority: 0,company_id:1 )
      end
      it "designation" do 
        @role.save
        @role.designation = "admin"
      end
      it "department" do 
        @role.save
        @role.department = "Company"
      end
      after(:each) do 
        expect(@role).to_not be_valid
      end
    end

    context "invalid fields" do 
      context "priority" do 
        it "less than 0" do
          @role.priority = -1
          expect(@role).to_not be_valid
        end
        it "alphabetics" do 
          @role.priority = "admin"
          expect(@role).to_not be_valid
        end
      end
    end

    context "valid fields" do 
      context "priority" do 
        it "greater than 0" do 
          @role.priority = 12
        end
      end
      after(:each) do 
        expect(@role).to_not be_valid
      end
    end
  end

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
    end
  end

  context "Asscociations" do 
    it "has one company_id" do 
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
  end


end
