class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
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
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\A\+\d+\z/
	validates :name,:phone,:start_time,:end_time , presence: true
	validates :phone ,format: {with: VALID_PHONE_REGEX}
	validates :start_time, :end_time, inclusion: {in: 0..23 }
	validates :end_time, presence: true, time: true

	before_save :lower_email

	def is_resource_available?
		if !self.resources.any?
			return false
		end
		true
	end

	protected 

	def lower_email
		self.email.downcase!
	end

end
