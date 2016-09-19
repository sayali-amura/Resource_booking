class Company < ActiveRecord::Base
	has_many :employees
	has_many :resources
	has_many :bookings
	has_many :roles
	validates :name, :address, presence: true
end
