class Employee < ActiveRecord::Base
	belongs_to :company
	belongs_to :role
	has_many :bookings
	has_many :complaints
	has_many :messages
	validates :employee, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "email format" }, uniqueness: true
    validates :name,:email, presence: true
	
end
