class Role < ActiveRecord::Base
	has_many :employees
	validates :priority ,inclusion: {in: 1..20}
end
