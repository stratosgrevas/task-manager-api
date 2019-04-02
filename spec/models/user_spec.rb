require 'rails_helper'

RSpec.describe User, type: :model do
  	#pending "add some examples to (or delete) #{__FILE__}"
  
  	# antes de cada teste, será executado o before!
  	before { @user = FactoryGirl.build(:user) }

  	# ####################
  	# Começando os testes
	# ####################
 
	# esste teste, espera que a instancia @user resposda pelo atributo e-mail 
	it { expect(@user).to respond_to(:email) }
	it { expect(@user).to respond_to(:name) }
	it { expect(@user).to respond_to(:password) }
	it { expect(@user).to respond_to(:password_confirmation) }
	it { expect(@user).to respond_to(:created_at) }
	it { expect(@user).to respond_to(:updated_at) }
	it { expect(@user).to respond_to(:id) }
	# objeto válido?
	#it { expect(@user).to be_valid }

end


#<User id: nil, email: "aniyah@klein.co", created_at: nil, updated_at: nil>