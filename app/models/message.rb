class Message < ActiveRecord::Base
	belongs_to :property, polymorphic: true
	validates :content, presence: true
end
