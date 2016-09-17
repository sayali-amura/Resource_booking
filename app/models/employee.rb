class Employee < ActiveRecord::Base
	belongs_to :company
	belongs_to :role
	has_many :bookings
	has_many :complaints
	has_many :messages
end
