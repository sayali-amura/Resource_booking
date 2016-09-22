class Complaint < ActiveRecord::Base
	belongs_to :employee
	belongs_to :resource
	has_many :messages , as: :property
	validates :status ,inclusion: {in:[0,1]}
end
