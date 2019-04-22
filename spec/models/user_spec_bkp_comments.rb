require 'rails_helper'

RSpec.describe User, type: :model do

	# economizar memória nos testes
	# :user é a variável.
	# o build do FactoryGirl só será executado
	# quando a variável "user" for chamada pela primeira vez no código
	# como logo abaixo.
	let(:user) { build(:user) }
  	
  	it { expect(user).to respond_to(:email) } # "user" sendo chamada!

  	# 
  	# Comentando o código dos testes para usar o 
  	# shoulda-matchers
  	# 
  	# context 'when name is blank' do
  	# 	before { user.name = " " }

  	# 	it { expect(user).not_to be_valid }
  	# end

  	# context 'when name is nil' do
  	# 	before { user.name = nil }

  	# 	it { expect(user).not_to be_valid }
  	# end

  	# 
  	# SHOULDA-MATCHERS
  	# Com esse recurso, testes de presença podem ser executados
  	# apenas em uma linha evitando testes repetitivos.
  	# 
  	# it { expect(user).to validate_presence_of(:name) }
  	
  	# Outra forma, sem especificar o usuário.
  	# pois o shoulda-matchers já entende que estamos
  	# trabalhando com uma instância do usuário.
  	it { is_expected.to validate_presence_of(:name) }
  	it { is_expected.to validate_presence_of(:email) }
  	
	# 
	# ABAIXO TEMOS OUTRAS FORMAS DE TRABALHAR COM TESTES #
	# 

  	###
  	### antes de cada teste, será executado o before! ###
  	###
  	
  	#subject { FactoryGirl.build(:user) } # No rails_helper.rb, já tem a definição da FactoryGirl.
  	#subject { build(:user) } # nesse caso, não precisa passar a palavra FactoryGirl.

  	#before { @user = FactoryGirl.build(:user) } # não é uma boa prática!

  	# ####################
  	# Começando os testes
	# ####################
 
	# esste teste, espera que a instancia @user resposda pelo atributo e-mail 
	#it { expect(@user).to respond_to(:email) }
	#it { expect(@user).to respond_to(:name) }
	#it { expect(@user).to respond_to(:password) }
	#it { expect(@user).to respond_to(:password_confirmation) }
	#it { expect(@user).to respond_to(:created_at) }
	#it { expect(@user).to respond_to(:updated_at) }
	#it { expect(@user).to respond_to(:id) }
	# objeto válido?
	#it { expect(@user).to be_valid }
	
	# boas práticas com subject
	#it { expect(subject).to respond_to(:email) }
	#it { expect(subject).to be_valid }
	
	# Nesse caso, não precisa passar o subject em 
	# "it { expect(subject).to respond_to(:email) }"
	# quando usamos is_expected o RSPEC já sabe que existe um subject.
	
	# it { is_expected.to respond_to(:email) }
	# it { is_expected.to respond_to(:name) }

end


#<User id: nil, email: "aniyah@klein.co", created_at: nil, updated_at: nil>