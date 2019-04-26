class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    # atributo virtual
	# attr_accessor :name

	# validates_presence_of :name, :age, :photo

	validates_uniqueness_of :auth_token	

	# MARCADOR DO VIDEO = filtro before_create e teste do token duplicado!
	before_create :generate_authentication_token!

	def info
		"#{email} - #{created_at} - Token: #{Devise.friendly_token}"
	end

	def generate_authentication_token!
		# begin - end - while.
		# Enquanto existir um usuário no sistema 
		# com o mesmo token gerado pelo Devise.friendly_token
		# o Devise.friendly_token deverá gerar outro token
		# para o usuário corrente!
		begin
			self.auth_token = Devise.friendly_token
		end while User.exists?(auth_token: auth_token)
	end
end
