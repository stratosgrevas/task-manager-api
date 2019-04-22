require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	# usando o create é para salvar no banco de 
	# dados esse objeto.
	let!(:user) { create(:user) }

	let(:user_id) { user.id }

	# before { host "api.dominio.dev" }

	describe "GET users/:id" do # action show
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
			get "/users/#{user_id}", params: {}, headers: headers
		end

		context "when the user exists" do
			it "returns the user" do
				user_response = JSON.parse(response.body)
				expect(user_response["id"]).to eq(user_id)
			end

			it "returns status code 200" do
				expect(response).to have_http_status(200)
			end
		end

		context "when the user does not exists" do
			let(:user_id) { 10000 }

			it "returns status code 404" do
				expect(response).to have_http_status(404)
			end
		end
	end

end
