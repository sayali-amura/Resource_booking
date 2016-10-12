require 'rails_helper'

RSpec.describe CompanyHelper, type: :helper do 
  	it "humanize timing" do 
  		result = "0:0"
  		expect(humanizing(Time.new("2016-10-10 00:00:00"))).to eq(result)
  	end
end
