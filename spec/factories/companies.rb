require 'faker'

FactoryGirl.define do
	factory :company do 
		name {Faker::Company.name}
		email {Faker::Internet.email}
		phone {"+91" << Faker::Number.number(10)}
		start_time {Faker::Time.between(DateTime.now - 1, DateTime.now)}
		end_time {Faker::Time.between(DateTime.now - 1, DateTime.now)}
		after(:create) do |company|
			create_list(:role, 3, company: company)
		end


	end

end