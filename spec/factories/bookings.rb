require 'faker'

FactoryGirl.define do
	factory :booking do 
		status {[0,1,2].sample}
		feedback {Faker::Lorem.sentence}
		comment {Faker::Lorem.sentence}
		date_of_booking {Faker::Date.between(Date.today, 2.days.from_now)}
		slot {[0,1,2].sample}
	end

end