require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	# usando o create é para salvar no banco de 
	# dados esse objeto.
	let!(:user) { create(:user) }

	let(:user_id) { user.id }

	# before { host 'api.dominio.dev' }

	describe 'GET users/:id' do # action show
		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			get "/users/#{user_id}", params: {}, headers: headers
		end

		context 'when the user exists' do
			it 'returns the user' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:id]).to eq(user_id)
			end

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end
		end

		context 'when the user does not exists' do
			let(:user_id) { 10000 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end

	describe 'POST /users' do
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
      		post '/users', params: { user: user_params }, headers: headers
		end

		context 'when the request param are valid' do
			let(:user_params) { attributes_for(:user) }

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end

			it 'returns the json data for the created user' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eq(user_params[:email])
			end
		end

		context 'when the request param are invalid' do
			let(:user_params) { attributes_for(:user, email: 'invalid.email@') }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end
		end
	end

	describe 'PUT /users/:id' do
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
      		put "/users/#{user_id}", params: { user: user_params }, headers: headers
		end

		context 'when the request param are valid' do
			let(:user_params) { { email: 'new_email@taskmanager.com'} }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the updated user' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response[:email]).to eq(user_params[:email])
			end
		end

		context 'when the request param are invalid' do
			let(:user_params) { { email: 'invalid_email@'} }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json data for the errors' do
				user_response = JSON.parse(response.body, symbolize_names: true)
				expect(user_response).to have_key(:errors)
			end
		end
	end

	describe 'DELETE /users/:id' do
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
      		delete "/users/#{user_id}", params: {}, headers: headers
		end

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end

		it 'removes the user from database' do
			expect( User.find_by(id: user.id) ).to be_nil
		end
	end

end
