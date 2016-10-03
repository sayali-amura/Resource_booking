class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
  	# byebug	
    unless value > record.start_time
      record.errors[attribute] << (options[:message] || "Enter End Time greater than start time")
    end
  end
end


class Company < ActiveRecord::Base
	has_many :roles
	has_many :resources
	has_many :employees
	has_many :bookings
	has_many :complaints
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\A\+\d+\z/
	validates :name,:phone,:start_time,:end_time , presence: true
	validates :phone ,format: {with: VALID_PHONE_REGEX}
	validates :end_time, presence: true, time: true

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
			@employee = self.employees.new(name: "Admin",email: "admin@#{self.name}.com",age:22,date_of_joining: Date.today,
									 manager_id: 0)
			@employee.role_id = @role.id
			if !@employee.save(validate: false)
				self.errors[:default] << "Error while adding default employee"
			end
		else
			self.errors[:default_role] << "Error while adding default role"
		end
	end


end
