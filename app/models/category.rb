class Category < ActiveRecord::Base
	
	# Gem FriendlyId 
	include FriendlyId
	friendly_id :description, use: :slugged

	#Associations
	has_many :ads

	#Validations
	validates_presence_of :description


	scope :order_by_description, -> {order(:description)}

end
