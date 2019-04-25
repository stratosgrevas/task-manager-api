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
end