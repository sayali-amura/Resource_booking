
class Booking < ActiveRecord::Base
	include Admin::ResourcesHelper
	belongs_to :employee
	belongs_to :resource
	belongs_to :company
	has_many	:messages, as: :property
	validates :slot,:date_of_booking,:comment , presence: true
	validates :priority ,inclusion: {in:[0,1,2]}	

	validate :is_slot_alloted?, :slot_valid?, :is_resource_valid?
	validate :is_resource_available?, on: :index

	before_save :add_company_id


	def is_slot_alloted?
		todays_booking = Booking.where("created_at >= ? and created_at<=?", Time.zone.now.beginning_of_day,Time.zone.now.end_of_day)
		if todays_booking.any?
			todays_booking.each do |booking|
				if booking.slot == self.slot
					self.errors[:allocated_slot] << "This slot is already alloted"
					break
				end
			end
		end
	end

	def slot_valid? 
		if self.slot > self.resource.timeslots.length
			self.errors[:slot_invalid] << "This slot is invalid"
		end
	end

	def is_resource_added_to_company?
		if !(self.employee.company.resources.any?)
			return false
		end
		true
	end

	def is_resource_valid?
		unless (Resource.find(self.resource_id))
			self.errors[:resource_not_present] << "Requested resource is not available."
		end
	end

	protected

	def add_company_id
		company = self.employee.company
		self.company_id = company[:id]
	end

end