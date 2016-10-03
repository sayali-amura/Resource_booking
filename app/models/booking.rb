
class Booking < ActiveRecord::Base
	include Admin::ResourcesHelper
	belongs_to :employee
	belongs_to :resource
	belongs_to :company
	has_many	:messages, as: :property

	before_create :is_slot_alloted?, :slot_valid?, :is_resource_valid?, :is_date_valid?,:check_holiday?
	before_validation 	:ensure_date_has_value,:add_company_id


	validates :slot,:date_of_booking,:comment , presence: true
	validates :status , inclusion: {in:[0,1,2]}
	validates :resource_id,:employee_id, :slot,:company_id, numericality: { only_integer: true }	
	validate :is_slot_alloted?,:slot_valid?, :is_date_valid?,:check_holiday?,:is_slot_already_passed?

	protected

	def is_date_valid?
		unless self.date_of_booking >= Time.zone.now.beginning_of_day 
			self.errors[:date_validation] << "You can't book resource for previous day"
		end
	end

	def check_holiday?
		unless self.date_of_booking.wday != 0 
			self.errors[:day_validation] << "Booking can't be done on holidays"
		end
	end

	def is_slot_alloted?
		if self.company.bookings.find_by_date_of_booking(self.date_of_booking)
			if self.new_record?
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking)
			else
				days_booking = self.company.bookings.where(date_of_booking: self.date_of_booking).where.not(id: self.id)
			end
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

	def is_slot_already_passed?
		unless self.date_of_booking != Time.zone.now.beginning_of_day 
			unless self.resource.next_time_slots.include?(self.resource.timeslots[self.slot])
				self.errors[:slot_avaibility] << "This slot is already passed"
			end
		end
	end

	def is_resource_added_to_company?
		if !(self.employee.company.resources.any?)
			return false
		end
		true
	end

	def is_resource_valid?
		unless (self.company.resources.find(self.resource_id))
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
	def self.ongoing_bookings(company)
		bookings_of_today = company.bookings.where("date_of_booking = ?",Date.today)
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