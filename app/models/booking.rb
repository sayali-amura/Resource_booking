
#
# Class Booking provides validations and associations to bookings
#
# @author Amrut Jadhav amrut@amuratech.com
#
class Booking 
	include Mongoid::Document
	include Mongoid::Timestamps
	#include Admin::ResourcesHelper  
	include Admin::ResourcesHelper

   field :feedback, type: String
   field :status, type: Integer, default:0
   field :date_of_booking, type: Date
   field :resource_id, type: BSON::ObjectId
   field :company_id, type: BSON::ObjectId
   field :slot, type: Integer
   field :employee_id, type: BSON::ObjectId
   field :comment, type: String


	

	# associations 
	belongs_to :employee
	belongs_to :resource
	belongs_to :company

	# callbacks
	# (see #add_company_id)
	before_validation 	:add_company_id

	# validations
	validates :slot,:date_of_booking,:comment , presence: true
	validates :status , inclusion: {in:[0,1,2]}
	#validates :resource_id,:employee_id,:company_id, numericality: { only_integer: true, less_than: 2147483647, greater_than: 0 }
	validates :slot, numericality: 	{ only_integer: true, less_than: 2147483647, greater_than_or_equal_to: 0 }

	# conditional validation 
	# (see #ensure_dependencies) 
	validate :is_slot_alloted?,:slot_valid?, :is_date_valid?,:check_holiday?,:is_slot_already_passed?, if: :ensure_dependencies

	protected
	#
	# Check whether the date of booking is past date
	#
	#
	# @return [void] Add error to self if date of booking is past date
	# 
	def is_date_valid?
		unless self.date_of_booking >= Time.zone.now.beginning_of_day 
			self.errors[:date_validation] << "=> You can't book resource for previous day"
		end
	end

	#
	# Checks whether the date of booking is holiday?
	#
	#
	# @return [void] Add error to self if date of booking is sunday
	# 
	def check_holiday?
		unless self.date_of_booking.wday != 0 
			self.errors[:day_validation] << "=> Booking can't be done on holidays"
		end
	end

	#
	# Check whether the requested time slot for booking is avaible or not
	#
	#
	# @return [void] add errors to self if slot is already alloted
	# 
	def is_slot_alloted?

		if self.company.bookings.where(date_of_booking: self.date_of_booking).first
			if self.new_record?
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking)
			else
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking).where(:id.ne => self.id)
			end
			days_booking.each do |x|
				unless x.slot != self.slot
					self.errors[:allocated_slot] << "=> This slot is already alloted"
				end
			end
		end
	end

	# 
	# Checks whether requested slot of booking is valid? i.e check whether  the requested slot is present in 
	#   in the reource's slot or not
	#
	# @return [void] Add error to self if slot is out of range of avaible slot of resource and it is not integer
	# 
	def slot_valid? 
		available_slots = self.resource.available_time_slot(self.date_of_booking.strftime("%Y%m%d") )
		available_slots.each do | slot |
			return if slot[1] == self.slot.to_i
		end
			self.errors[:slot_invalid] << "=> This slot is invalid"
	end

	#
	# If date of booking is today check whether the requested time slot is already passed?
	#
	# @return [void] Add errors to self if slot is already passed
	# 
	def is_slot_already_passed?
		unless self.date_of_booking != Time.zone.now.beginning_of_day 
			unless self.resource.next_time_slots.include?(self.resource.timeslots[self.slot])
				self.errors[:slot_avaibility] << "=> This slot is already passed"
			end
		end
	end

	#
	# Check whether any resources are added to company?
	#
	#
	# @return [Boolean] If there are not resources in company return false else true
	# 
	def is_resource_added_to_company?
		if !(self.employee.company.resources.any?)
			return false
		end
		true
	end

	# Check whether date_of_bookingg is empty
	#
	#
	# @return [Boolean] Whether dependencies are present or not 
	# 
	def ensure_dependencies
		unless !self.date_of_booking.blank?
			self.errors[:date_of_booking] << "=> Date of booking can't be empty"
			return false
		end
		unless ( self.company.resources.find_by(id:self.resource_id) )
			self.errors[:resource_not_present] << "=> Requested resource is not available."
			return false
		end
		true
	end	

	# Add company_id to booking
	#
	#
	# @return [void] Add company_id to self
	# 
	def add_company_id
		company = self.employee.company
		self.company_id = company[:id]
	end

	# Returns currently going on meetings in company
	#
	# @param [Company] company The object of company model
	#
	# @return [Array] current_bookings The currently going on bookings objects
	# 
	def self.ongoing_bookings(company)
		bookings_of_today = company.bookings.where(:date_of_booking.gte => Date.today)
		granted = bookings_of_today.where(status:1)
		current_bookings = []
		granted.each do | booking |
			resource = booking.resource
			timeslot_min = resource.time_slot.min
			timeslot_hour = resource.time_slot.hour
			start_time = booking.company.start_time
			start_min = (start_time.min + (booking.slot) * timeslot_min) % 60
			carry_hours = (start_time.min + (booking.slot) * timeslot_min) / 60
			start_hour = start_time.hour + (booking.slot) * timeslot_hour + carry_hours
			end_min = (start_time.min + (booking.slot + 1) * timeslot_min) % 60
			carry_end_hours = (start_time.min + (booking.slot + 1) * timeslot_min) / 60
			end_hour = start_time.hour + (booking.slot + 1) * timeslot_hour + carry_end_hours
			if Time.now.hour.between?(start_hour,end_hour) and end_hour != 0
				#byebug
				if end_min != 0 and Time.now.min.between?(start_min,end_min)
					current_bookings << booking
				else
					if Time.now.min.between?(start_min,59) and end_min == 0
						current_bookings << booking
					end
				end
			elsif Time.now.hour.between?(start_hour,23) and end_hour == 0
						current_bookings << booking
			end 		
		end
		current_bookings
	end

end
