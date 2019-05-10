class Task < ApplicationRecord
	belongs_to :user

	validates_presence_of :title, :user_id

	# Outra maneira de especificar as validações de presença é:
	# validates :title, :user_id, presence: true
	
end
