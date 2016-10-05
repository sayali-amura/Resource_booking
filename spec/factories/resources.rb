require 'faker'
require 'as-duration'

FactoryGirl.define do
	factory :resource do |r|
		r.name {Faker::Lorem.word}
		r.time_slot {1.hour}
		company
	end
end 