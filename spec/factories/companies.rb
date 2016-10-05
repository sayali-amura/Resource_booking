require 'faker'

FactoryGirl.define do
	factory :company do |c| 
		c.name {Faker::Company.name}
		c.email {Faker::Internet.email}
		c.phone {Faker::PhoneNumber.cell_phone}
		c.start_time {Faker::Time.between(DateTime.now - 1, DateTime.now)}
		c.end_time {Faker::Time.between(DateTime.now - 1, DateTime.now)}
	end
end