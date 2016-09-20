class Resource < ActiveRecord::Base
	validates :count, numericality: { only_integer: true, greater_than: 0 }
	validates :name, :count, presence: true
end
