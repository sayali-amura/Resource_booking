class Company < ActiveRecord::Base
	has_many :employees
	has_many :resources
	has_many :bookings
end
