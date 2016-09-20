class Booking < ActiveRecord::Base
	belongs_to :employee
	has_many	:messages
	validates :duration,:employee_id, presence: true
	validates :status ,inclusion: {in:[1,2,3,4]}
	validates :priority ,inclusion: {in:[1,2,3]}
	
end
