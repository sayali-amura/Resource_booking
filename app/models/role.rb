class Role < ActiveRecord::Base
	belongs_to :company
	has_many :employees
	# validates :priority ,inclusion: {in: 0..19}
	validates :designation, :department, :priority, presence: true
	validates :priority, numericality: { only_integer: true, greater_than: 0 }
	validates :designation, uniqueness:{scope: :department, message: "Designnation in department should be unique"}
	validates :priority, uniqueness:{scope: :company_id, message: "Priority should be uniq across the company"}
	validates :department, uniqueness:{scope: :company_id, message: "Department should be uniq across the company"}

	validate :is_name_admin?

	before_validation :lower_fields

	private 

	def is_name_admin?
		unless self.designation != 'admin' 
			self.errors[:admin_designation] << "=>You can't assign the admin designation to anthoer employees"
		end
	end

	def lower_fields
		self.designation.downcase!
		self.department.downcase!
	end




end
