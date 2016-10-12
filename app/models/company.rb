#
# Class TimeValidator provides custom validation for comparing start_time and end_time
#
class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value > record.start_time
      record.errors[attribute] << (options[:message] || "Enter End Time greater than start time")
    end
  end
end

#
# Class Company provides validation and associations for company object
#
# @author Amrut Jadhav  amrut@amuratech.com	
#
class Company < ActiveRecord::Base
	# Associations
	has_many :roles, dependent: :destroy
	has_many :resources, dependent: :destroy
	has_many :employees, dependent: :destroy
	has_many :bookings, dependent: :destroy
	has_many :complaints, dependent: :destroy

	# Email regex
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	# Company phone regex 
	VALID_PHONE_REGEX = /\A\+\d+\z/
	
	# Validations
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	validates :name,:phone,:start_time,:end_time , presence: true
	validates :phone ,format: {with: VALID_PHONE_REGEX,message: "Not a valid phone number format"}, uniqueness: true
	validates :end_time, presence: true, time: true, if: :ensure_timing_has_value

	# Callbacks
	# (see #lower_fields)
	before_save :lower_fields
	after_create :add_defaults, :add_empty_role

	#
	# Checks whether any resources are added to company 
	#
	#
	# @return [Boolean] return true if company has resources else false
	# 
	def is_resource_available?
		(self.resources.any?) ? true : false
	end

	private

	#
	# Downcase the email and name of company
	#
	#
	# @return [<type>] <description>
	# 
	def lower_fields
		self.email.downcase!
		self.name.downcase!
	end


	#
	# Create none role for company
	#
	#
	# @return [void] Add none role to company
	# 
	def add_empty_role
		empty_role = self.roles.build(designation: "none",department: self.name,priority: 0)
		empty_role.skip_validation = true
		empty_role.save
	end

	#
	# Create default roles and admin for company 
	#
	#
	# @return [void] Add default role and admin to company
	# 
	def add_defaults
		@role = self.roles.build(designation: "admin",department: self.name,priority: 1 )
		@role.skip_validation = true     # to skip validation of role to add admin role in company
		if @role.save(validate: false)
			@employee = self.employees.build(name: "admin",email: self.email ,age:22,date_of_joining: Date.today)
			@employee.skip_password_validation = true
			@employee.skip_validation = true         # to skip validation of manager id
			@employee.role_id = @role.id
			# byebug
			if !@employee.save
				self.errors[:default] << "Error while adding default employee"
			else
				@employee.manager_id = @employee.id
				@employee.save
			end

		else
			self.errors[:default_role] << "Error while adding default role"
		end
	end

	#
	# Check whether start_time and time_time is provided for company
	#
	#
	# @return [Boolean] If both fields given return true else false
	# 
	def ensure_timing_has_value
		if (self.start_time.blank? || self.end_time.blank?)
			self.errors[:timing] << "=> Provide start and end timing for Company"
			return false
		end
		true
	end	

end


