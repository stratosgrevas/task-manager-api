class Api::V2::SessionsController < ApplicationController
	def create
		user = User.find_by(email: session_params[:email])

		# valid_password é uma função helper fornecido pleo DEVISE
		# essa função recebe a senha do usuário na forma de string
		# mas o DEVISE quando cria o usuário no banco, 
		# salva a senha do usuário de forma criptografada.
		if user && user.valid_password?(session_params[:password])
			sign_in user, store: false

			# gera e atualiza um novo token para o usuário
			user.generate_authentication_token!
			user.save

			render json: user, status: 200
		else
			render json: {errors: 'Invalid password or email'}, status: 401
		end
	end

	def destroy
		user = User.find_by(auth_token: params[:id])
		user.generate_authentication_token!
		user.save
		head 204
	end

	private

	def session_params
		params.require(:session).permit(:email, :password)
	end

end
