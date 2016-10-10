require 'faker'

FactoryGirl.define do
	factory :employee do
		email {Faker::Internet.email}
		name {Faker::Name.name}
		age {Faker::Number.number(2)}
		date_of_joining {Faker::Date.between(2.years.ago, Date.today)}
		password {Faker::Internet.password(6, 20)}
		password_confirmation { password }
		confirmed_at Date.today
	end
end