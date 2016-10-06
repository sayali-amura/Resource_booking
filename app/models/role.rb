class Role < ActiveRecord::Base
	belongs_to :company
	has_many :employees

	validates :designation, :department, :priority, presence: true
	validates :priority, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 2147483647 }

	validates :designation, uniqueness:{scope: [:company_id,:department], message: "Designation in department should be unique"}
	validates :priority, uniqueness:{scope: :company_id, message: "Priority should be uniq across the company"}


	validate :is_name_admin?, :is_none_fields

	before_validation :lower_fields

	after_destroy :add_default_role
	
	private 

	def is_none_fields
		unless designation!="none" || department!="none"
			self.errors[:none] << "=> You can't create none role"
		end
	end

	def add_default_role 
		empty_role_id = self.company.roles.find_by_designation("none").id
		if self.employees.any? 
			self.employees.each do |x| 
				x.skip_password_validation = true
				x.update(role_id: empty_role_id)
			end
		end
	end


	def is_name_admin?
		unless self.designation != 'admin' 
			self.errors[:admin_designation] << "=>You can't assign the admin designation to anthoer employees"
		end
	end

	def lower_fields
		if self.designation and self.department
			self.designation.downcase!
			self.department.downcase!
		end
	end

end
