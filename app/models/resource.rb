class Resource < ActiveRecord::Base
	belongs_to :company
	validates :count, numericality: { only_integer: true, greater_than: 0 }
	validates :name, :count, presence: true
end
