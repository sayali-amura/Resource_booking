class Booking < ActiveRecord::Base
	belongs_to :employee
	has_many	:messages
end
