require 'faker'

FactoryGirl.define do
	factory :role do
		designation {(0...8).map { (65 + rand(26)).chr }.join}
		department {Faker::Company.profession}
		#priority {SecureRandom.random_number(1000)}
		priority {rand(1..1000000)}
	end
end