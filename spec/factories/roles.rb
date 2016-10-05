require 'faker'

FactoryGirl.define do
	factory :role do |r|
		r.designation {Faker::Company.profession}
		r.department {Faker::Company.profession}
		r.priority {Faker::Number.number(2)} 
	company
	end
end