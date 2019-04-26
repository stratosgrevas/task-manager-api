require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { build(:user) }
  	
  	it { is_expected.to validate_presence_of(:email) }
  	it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  	it { is_expected.to validate_confirmation_of(:password) }
  	it { is_expected.to allow_value('costa@nonato.com').for(:email) }
  	it { is_expected.to validate_uniqueness_of(:auth_token) }

  	# Quando um describe tiver um '#+alguma palavra', será um teste de instância
  	# ou teste de função que vai estar no seu model.
  	describe '#info' do
  		it 'returns email and created_at and a Token' do
  			user.save!

  			# criando um MOCK
  			allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

  			# PXab_qssWAEG3nQ12svm - token de exemplo gerado pelo Devise.friendly_token
  			# comando rodado no console rails c
  			expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
  		end
  	end

  	describe '#generate_authentication_token!' do
  		it 'generates a unique auth token' do
			# criando um MOCK
  			allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
  			user.generate_authentication_token!

  			expect(user.auth_token).to eq('abc123xyzTOKEN')
  		end

  		it 'generates another auth token when the current auth token already has been taken' do
  			# criei um usuário no sistema com o token = abc123tokenxyz
  			# a função CREATE é do FACTORY_GIRL que gera dados de usuários
  			# e salva no banco de dados de teste!
  			# existing_user = create(:user, auth_token: 'abc123tokenxyz')
  			
  			# allow é um MOCK. 
  			# Nesse caso, quando for rodado o friendly_token, 
  			# na primeira tentativa o retorno receberá "abc123tokenxyz"
  			# e caso exista um token já salvo no banco, eu faço uma segunda tentativa
  			# passando o valor do token = "abcXYZ123456789"
  			# allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz','abcXYZ123456789')

  			# MARCADOR DO VIDEO = filtro before_create e teste do token duplicado!
  			allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz','abc123tokenxyz','abcXYZ123456789')
  			existing_user = create(:user)
  			
  			# fazendo a chamda do método do model.
  			user.generate_authentication_token!

  			# expero que o token do usuário corrente, não seja 
  			# igual a um token de usuário já existente no banco.
  			expect(user.auth_token).not_to eq(existing_user.auth_token)
  		end
  	end

end