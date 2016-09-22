class Company < ActiveRecord::Base
	has_many :roles
	has_many :resources
	has_many :employees
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: {with: VALID_EMAIL_REGEX },
																uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\A\+\d+\z/
	validates :name,:phone,:start_time,:end_time , presence: true
	validates :phone ,format: {with: VALID_PHONE_REGEX}
end
