class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value > record.start_time
      record.errors[attribute] << (options[:message] || "Enter End Time greater than start time")
    end
  end
end
class Company < ActiveRecord::Base
	has_many :roles, dependent: :destroy
	has_many :resources, dependent: :destroy
	has_many :employees, dependent: :destroy
	has_many :bookings, dependent: :destroy
	has_many :complaints, dependent: :destroy
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\A\+\d+\z/
	validates :name,:phone,:start_time,:end_time , presence: true
	validates :phone ,format: {with: VALID_PHONE_REGEX,message: "Not a valid phone number format"}, uniqueness: true
	validates :end_time, presence: true, time: true, if: :ensure_timing_has_value

	before_save :lower_fields
	after_save :add_defaults

	def is_resource_available?
		(self.resources.any?) ? true : false
	end

	private

	def lower_fields
		self.email.downcase!
		self.name.downcase!
	end

	def add_defaults
		@role = self.roles.create(designation: "Admin",department: self.name,priority: 0 )
		if @role.save(validate: false)
			@employee = self.employees.new(name: "Admin",email: self.email ,age:22,date_of_joining: Date.today)
			@employee.role_id = @role.id
			if !@employee.save(validate: false)
				self.errors[:default] << "Error while adding default employee"
			else
				@employee.manager_id = @employee.id
				@employee.save(validate: false)
			end

		else
			self.errors[:default_role] << "Error while adding default role"
		end
	end

	def ensure_timing_has_value
		if (self.start_time.blank? || self.end_time.blank?)
			self.errors[:timing] << "=> Provide start and end timing for Company"
			return false
		end
	end	

end


