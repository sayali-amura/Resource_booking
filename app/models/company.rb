class Company < ActiveRecord::Base
	has_many :roles
	has_many :resources
	has_many :employees
end
