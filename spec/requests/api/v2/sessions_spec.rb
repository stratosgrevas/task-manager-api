require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
	# before { host 'api.dominio.dev' }
	
	let(:user) { create(:user) }

	let!(:auth_data) { user.create_new_auth_token }

	# Accept = versão da api
	let(:headers) do
		{
			'Accept' => 'application/vnd.taskmanager.v2',
			'Content-Type' => Mime[:json].to_s,
			'access-token' => auth_data['access-token'],
			'uid' => auth_data['uid'],
			'client' => auth_data['client']
		}
	end

	# criar a sessão do usuário
	# login com o devise token auth
	describe 'POST /auth/sign_in' do
		before do
			post '/auth/sign_in', params: credentials.to_json, headers: headers
		end

		context 'when the credentials are correct' do
			# o password '123456' deve ser o mesmo criado no arquivo
			# FACTORY_GIRL para passar nesse teste.
			let(:credentials) { { email: user.email, password: '123456' } }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the authentication data in the headers' do
				expect(response.headers).to have_key('access-token')
				expect(response.headers).to have_key('uid')
				expect(response.headers).to have_key('client')				
			end
		end

		context 'when the credentials are incorrect' do
			let(:credentials) { { email: user.email, password: 'invalid_password' } }

			# 401 = não autorizado
			it 'returns status code 401' do
				expect(response).to have_http_status(401)
			end

			it 'returns the json data for the errors' do
				expect(json_body).to have_key(:errors)
			end
		end
	end

	# destruir a sessão do usuário
	# logout com o devise token auth
	describe 'DELETE /auth/sign_out' do
		let(:auth_token) { user.auth_token }

		before do
			delete '/auth/sign_out', params: {}, headers: headers
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end

		# logout com o devise token auth
		it 'changes the user auth token' do
			# recarrega o usuário para pegar os dados atualizados do banco de dados.
			user.reload

			# valid_token? é uma função do devise token auth
			# que pode ser localizada dentro do DOC dessa gem
			expect( user.valid_token?(auth_data['access-token'], auth_data['client']) ).to eq(false)

			# outra maneira de executar o mesmo teste:
			# expect( user ).not_to be_valid_token(auth_data['access-token'], auth_data['client'])
		end
	end
end