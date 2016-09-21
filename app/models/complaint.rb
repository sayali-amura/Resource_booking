class Complaint < ActiveRecord::Base
	belongs_to :employee
	has_many :messages , as: :property
	validates :status ,inclusion: {in:[1,2,3,4]}
end
