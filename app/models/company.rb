class Company < ActiveRecord::Base
	has_many :roles
	has_many :resources
	has_many :employees
	has_many :bookings
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\A\+\d+\z/
	validates :name,:phone,:start_time,:end_time , presence: true
	# validates :end_time, numericality:{greater_than: end_time }
	validates :phone ,format: {with: VALID_PHONE_REGEX}


	before_save :lower_email

	def is_resource_available?
		(self.resources.any?) ? true : false
	end

	protected 

	def lower_email
		self.email.downcase!
	end

end
