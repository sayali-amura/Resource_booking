class Resource < ActiveRecord::Base
	belongs_to :company
	validates :count, numericality: { only_integer: true }
	validates :name, :count, presence: true
end
