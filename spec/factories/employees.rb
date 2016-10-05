require 'faker'

FactoryGirl.define do
	factory :employee do |e|
		e.email {Faker::Internet.email}
		e.name {Faker::Name.name}
		e.age {Faker::Number.number(2)}
		e.date_of_joining
		e.manager_id
		role
		company
	end
end