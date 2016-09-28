class Role < ActiveRecord::Base
	belongs_to :company
	has_many :employees
	validates :priority ,inclusion: {in: 0..19}
end
