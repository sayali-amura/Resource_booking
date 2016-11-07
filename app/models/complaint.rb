#
# Class Complaint provides associations and validations for complaint object
#
# @author Amrut Jadhav amrut@amuratech.com
#
class Complaint 
	include Mongoid::Document
	include Mongoid::Timestamps


  field :status, type: Integer, default:0
  field :resource_id, type: BSON::ObjectId
  field :company_id, type: BSON::ObjectId
  field :employee_id, type: BSON::ObjectId
  field :comment, type: String


	# Associations 
	belongs_to :employee
	belongs_to :resource
	belongs_to :company

	# Validations
	validates :status ,inclusion: {in:[0,1]}
	validates :comment, presence: true
	#validates :resource_id, :employee_id, numericality: { only_integer: true, less_than: 2147483647, greater_than: 0 }

end
