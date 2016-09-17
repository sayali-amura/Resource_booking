class Employee < ActiveRecord::Base
	belongs_to :company
	has_one :role
	has_many :bookings
	has_many :complaints
	has_many :messages
end
