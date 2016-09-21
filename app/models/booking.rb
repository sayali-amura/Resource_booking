class Booking < ActiveRecord::Base
	belongs_to :employee
	has_many	:messages
	validates :duration, presence: true
	validates :priority ,inclusion: {in:[0,1,2]}	
end
