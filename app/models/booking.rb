
class Booking < ActiveRecord::Base
	include Admin::ResourcesHelper
	belongs_to :employee
	belongs_to :resource
	belongs_to :company
	has_many	:messages, as: :property

	before_create :is_slot_alloted?, :slot_valid?, :is_resource_valid?, :is_date_valid?,:check_holiday?
	before_validation 	:ensure_date_has_value,:add_company_id, :ensure_is_resource_valid


	validates :slot,:date_of_booking,:comment , presence: true
	validates :priority ,inclusion: {in:[0,1,2]}	
	validates :status , inclusion: {in:[0,1,2]}
	validates :resource_id,:employee_id, :slot,:company_id, numericality: { only_integer: true }	
	validate :is_slot_alloted?,:slot_valid?, :is_date_valid?,:check_holiday?


	# before_save :add_company_id
	
	protected

	def is_date_valid?
		unless self.date_of_booking >= Time.zone.now.beginning_of_day 
			self.errors[:date_validation] << "You can't book resource for previous day"
		end
	end

	def check_holiday?
		unless self.date_of_booking.wday!=7 
			self.errors[:day_validation] << "Booking can't be done on holidays"
		end
	end

	def is_slot_alloted?
		if self.company.bookings.find_by_date_of_booking(self.date_of_booking)
			if self.new_record?
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking)
			else
<<<<<<< HEAD
				# byebug
=======
>>>>>>> c2c41e314988f9bfa7686e017b2aa6d4d14e1906
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking).where.not(id: self.id)
			end
			# binding.pry
			# byebug
			days_booking.each do |x|
				unless x.slot != self.slot
					self.errors[:allocated_slot] << "This slot is already alloted"
				end
			end
		end
	end

	def slot_valid? 
		if self.slot.to_i > self.resource.available_time_slot(self.date_of_booking).length || self.slot%1!=0
			self.errors[:slot_invalid] << "This slot is invalid"
		end
	end

	def is_resource_added_to_company?
		if !(self.employee.company.resources.any?)
			return false
		end
		true
	end

<<<<<<< HEAD
	def ensure_is_resource_valid
		unless self.company.resources.find_by_id(self.resource_id)  
=======
	def is_resource_valid?
		unless (self.company.resources.find(self.resource_id))
>>>>>>> c2c41e314988f9bfa7686e017b2aa6d4d14e1906
			self.errors[:resource_not_present] << "Requested resource is not available."
			raise "resource is not valid"
		end
	end

	def ensure_date_has_value
		unless !self.date_of_booking.blank?
			self.errors[:date_of_booking] << "=>Date of booking can't be empty"
			raise "date_of_booking empty"
		end
	end	

	def add_company_id
		company = self.employee.company
		self.company_id = company[:id]
	end

end