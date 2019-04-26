require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
	# before { host 'api.dominio.dev' }
	
	let(:user) { create(:user) }

	# Accept = versão da api
	let(:headers) do
		{
			'Accept' => 'application/vnd.taskmanager.v1',
			'Content-Type' => Mime[:json].to_s
		}
	end

	# criar a sessão do usuário
	describe 'POST /sessions' do
		before do
			post '/sessions', params: { session: credentials }.to_json, headers: headers
		end

		context 'when the credentials are correct' do
			# o password '123456' deve ser o mesmo criado no arquivo
			# FACTORY_GIRL para passar nesse teste.
			let(:credentials) { { email: user.email, password: '123456' } }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the user with auth token' do
				user.reload
				expect(json_body[:auth_token]).to eq(user.auth_token)
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
	describe 'DELETE /sessions' do
	end
end