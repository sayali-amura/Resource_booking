#
# Class Complaint provides associations and validations for complaint object
#
# @author Amrut Jadhav amrut@amuratech.com
#
class Complaint 

	# include mongoid dependancies
	include Mongoid::Document
	include Mongoid::Timestamps

	# specify modle fields
	field	:created_at, type: DateTime
	field	:updated_at, type: DateTime
	field	:comment, type: String
	field	:status, type: String
	field	:resource_id, type: Integer
	field	:employee_id, type: Integer
	field	:company_id, type: Integer

	# define index
	index({employee_id: 1})

	# Associations 
	belongs_to :employee
	belongs_to :resource
	belongs_to :company

	# Validations
	validates :status ,inclusion: {in:[0,1]}
	validates :comment, presence: true
	validates :resource_id, :employee_id, numericality: { only_integer: true, less_than: 2147483647, greater_than: 0 }

end
