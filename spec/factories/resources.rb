require 'faker'
require 'as-duration'

FactoryGirl.define do
	factory :resource do
		name {(0...8).map { (65 + rand(26)).chr }.join}
		time_slot {Time.new(2016,12,3,[0,1,2,3].sample,(0..59).to_a.sample)}
	end
end 