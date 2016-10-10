require 'faker'

FactoryGirl.define do
	factory :complaint do 
		status {[0,1].sample}
		comment {Faker::Lorem.sentence}
	end

end