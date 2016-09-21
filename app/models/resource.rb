class Resource < ActiveRecord::Base
	belongs_to :company
	has_many :bookings
	validates :count, numericality: { only_integer: true, greater_than: 0 }
	validates :name, :count, presence: true

end
