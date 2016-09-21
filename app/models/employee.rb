class Employee < ActiveRecord::Base
	belongs_to :role
	belongs_to :company
	has_many :bookings
	has_many :complaints
	has_many :messages
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "email format" }, uniqueness: true
    validates :name,:email, presence: true
	
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
