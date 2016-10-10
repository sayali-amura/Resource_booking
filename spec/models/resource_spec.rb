require 'rails_helper'
require 'byebug'

  # belongs_to :company
  # has_many :bookings, dependent: :destroy
  # has_many :complaints, dependent: :destroy

RSpec.describe Resource, type: :model do
	before(:each) do 
		@company = create(:company)
    @resource = @company.resources.last
	end
  context "validations" do  
    it "must have time_slot" do
      @resource.time_slot = nil
      expect(@resource).to_not be_valid
    end
    context "name" do 
      it "unique across company" do
        @resource.name = "Same"
        @resource1 = Resource.new(name: "Same",time_slot: "67:90",company_id:1)
        expect(@resource1).to_not be_valid
      end
    end
  end

  context "Association" do 
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
  end
  context "time_slot method" do
    it "returns slot array string" do
      array = @resource.timeslots
      expect(array.sample.first).to be_kind_of(String)
    end
    it "returns slot array integer" do
      array = @resource.timeslots
      expect(array.sample.last).to be_kind_of(Integer)
    end
  end

end
