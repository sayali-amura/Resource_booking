require 'faker'
require 'as-duration'

FactoryGirl.define do
	factory :resource do
		name {Faker::Lorem.word}
		time_slot {1.hour}
		company
	end
end 