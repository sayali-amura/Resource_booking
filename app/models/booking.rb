class Booking < ActiveRecord::Base
	belongs_to :employee
	belongs_to :resource
	has_many	:messages, as: :property
	validates :slot,:date_of_booking,:comment , presence: true
	validates :priority ,inclusion: {in:[0,1,2]}	
end
