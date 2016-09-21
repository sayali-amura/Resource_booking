class Booking < ActiveRecord::Base
	belongs_to :employee
	belongs_to :resource
	has_many	:messages, as: :property
<<<<<<< HEAD
=======
	validates :slot,:date_of_booking,:comment , presence: true
>>>>>>> 0c7266ccf5d01206e38cdd218f44e3d715d10ecb
	validates :priority ,inclusion: {in:[0,1,2]}	
end
