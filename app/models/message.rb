class Message < ActiveRecord::Base
	belongs_to :property, polymorphic: true
end
