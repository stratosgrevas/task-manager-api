require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	# usando o create é para salvar no banco de 
	# dados esse objeto.
	let!(:user) { create(:user) }

	#let!(:user_id) { user.id }

	let!(:auth_data) { user.create_new_auth_token }

	let(:headers) do
		{
			'Accept' => 'application/vnd.taskmanager.v2',
			'Content-Type' => Mime[:json].to_s,
			'access-token' => auth_data['access-token'],
			'uid' => auth_data['uid'],
			'client' => auth_data['client']
		}
	end

	# before { host 'api.dominio.dev' }

	describe 'GET /auth/validate_token' do # action show
		before do
			get '/auth/validate_token', params: {}, headers: headers
		end

		context 'when the request headers are valid' do
			it 'returns the use id' do
				# Exemplo não refatorado, ou seja, sem helper
				# user_response = JSON.parse(response.body, symbolize_names: true)
				# expect(user_response[:id]).to eq(user.id)
				expect(json_body[:data][:id].to_i).to eq(user.id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the request headers are not valid' do
			before do
				headers['access-token'] = "Invalid token"
				get '/auth/validate_token', params: {}, headers: headers
			end

			it 'returns status code 401' do
				expect(response).to have_http_status(401)
			end
		end
	end

	describe 'POST /auth' do
		before do
      		post '/auth', params: user_params.to_json, headers: headers
		end

		context 'when the request param are valid' do
			let(:user_params) { attributes_for(:user) }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the created user' do
				expect(json_body[:data][:email]).to eq(user_params[:email])
			end
		end

		context 'when the request param are invalid' do
			let(:user_params) { attributes_for(:user, email: 'invalid.email@') }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				expect(json_body).to have_key(:errors)
			end
		end
	end

	describe 'PUT /auth' do
		before do
      		put '/auth', params: user_params.to_json, headers: headers
		end

		context 'when the request param are valid' do
			let(:user_params) { { email: 'new_email@taskmanager.com'} }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the updated user' do
				expect(json_body[:data][:email]).to eq(user_params[:email])
			end
		end

		context 'when the request param are invalid' do
			let(:user_params) { { email: 'invalid_email@'} }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				expect(json_body).to have_key(:errors)
			end
		end
	end

	describe 'DELETE /auth' do
		before do
      		delete '/auth', params: {}, headers: headers
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end

		it 'removes the user from database' do
			expect( User.find_by(id: user.id) ).to be_nil
		end
	end

end
