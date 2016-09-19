class Resource < ActiveRecord::Base
	belongs_to :company


	validates :name, presence: :true
	validates :count , presence: :true, numericality: {greater_than: 0, only_integer: true}

end
