class Complaint < ActiveRecord::Base
	belongs_to :employee
	belongs_to :company
	validates :status ,inclusion: {in:[1,2,3,4]}
end
