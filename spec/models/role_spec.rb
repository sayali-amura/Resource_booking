require 'rails_helper'
require 'share_example.rb'

RSpec.describe Role, type: :model do
  before(:each) do 
    @company = Company.new(name: "hello1",email: "hello2@gmail.com",phone: "+911254567890",start_time:9.00,end_time: 6.00)
	@role = @company.roles.new(designation: "Admin",department: @company.name,priority: 0 )
  end

  context "check table entries" do 
  	it "is it empty?" do 
  		expect("Role.all.count").to_not eq(0)
  	end
  	it "is entries adding?" do 
  		expect{@role.save}.to change(Role,:count).by(1)
  	end
  end

end
