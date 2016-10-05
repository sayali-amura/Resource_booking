require 'faker'

FactoryGirl.define do
	factory :role do
		designation {Faker::Company.profession}
		department {Faker::Company.profession}
		priority {Faker::Number.number(2)}
	end
end