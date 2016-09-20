class Complaint < ActiveRecord::Base
	belongs_to :employee
	validates :status ,inclusion: {in:[1,2,3,4]}
end
