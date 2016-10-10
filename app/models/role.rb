#
# Class Role provides functionality to handle roles related to company
#
# @author Amrut Jadhav
#
class Role < ActiveRecord::Base

	# Associations
	belongs_to :company
	has_many :employees

	# Validations
	validates :designation, :department, :priority, presence: true
	validates :priority, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 2147483647 }

	validates :designation, uniqueness:{scope: [:company_id,:department], message: "Designation in department should be unique"}
	validates :priority, uniqueness:{scope: :company_id, message: "Priority should be uniq across the company"}

	# Custom validation
	validate :is_name_admin?, :is_none_fields

	# Callbacks
	before_validation :lower_fields
	after_destroy :add_default_role
	
	private 

	#
	# Check whether user tries to add none role to company
	#
	#
	# @return [void] Add errors to self if role is none
	# 
	def is_none_fields
		unless self.designation!="none" && self.department!="none"
			self.errors[:none] << "=> You can't create none role"
		end
	end

	#
	# When a particular role is deleted then make roles of associated employee as none
	#
	#
	# @return [void] Update the associated employees role as default
	# 
	def add_default_role 
		empty_role_id = self.company.roles.find_by_designation("none").id
		if self.employees.any? 
			self.employees.each do |x| 
				x.skip_password_validation = true
				x.update(role_id: empty_role_id)
			end
		end
	end

	#
	# Check whether user trying to add admin role to company
	#
	#
	# @return [void] Add error to self if role is admin
	# 
	def is_name_admin?
		unless self.designation != 'admin' 
			self.errors[:admin_designation] << "=> You can't assign the admin designation to anthoer employees"
		end
	end

	#
	# Downcase the department and designation field of role
	#
	#
	# @return [void] Downcase the fields
	# 
	def lower_fields
		if self.designation and self.department
			self.designation.downcase!
			self.department.downcase!
		end
	end

end
