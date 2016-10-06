require 'faker'

FactoryGirl.define do
	factory :role do
		designation {Faker::Company.profession}
		department {Faker::Company.profession}
		#priority {SecureRandom.random_number(1000)}
		priority {rand(1..1000000)}
	end
end