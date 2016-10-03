class Complaint < ActiveRecord::Base
	belongs_to :employee
	belongs_to :resource
	belongs_to :company

	validates :status ,inclusion: {in:[0,1]}
	validates :comment, presence: true
	validates :resource_id, :employee_id, numericality: { only_integer: true }
	def self.resource_ids(company_id)
		@resources = Resource.where(company_id:company_id)
		@id_array = []
		@resources.each do | resource |
			@id_array << resource.id
		end
		@id_array
	end

end
