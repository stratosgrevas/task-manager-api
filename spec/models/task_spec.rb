require 'rails_helper'

RSpec.describe Task, type: :model do
	# build é um metodo do FactoryGirl para criar uma nova task
	let(:task) { build(:task) }

	context 'When is new' do
		# done = campo boolean da tabela.
		# se fosse published e esse campo for boolean,
		# poderia ser .not_to be_published
		it { expect(task).not_to be_done }
	end

	# validação de relacionamento entre models.
	it { is_expected.to belong_to(:user) }

	it { is_expected.to validate_presence_of :title }
	it { is_expected.to validate_presence_of :user_id }

	it { is_expected.to respond_to(:title) }
	it { is_expected.to respond_to(:description) }
	it { is_expected.to respond_to(:deadline) }
	it { is_expected.to respond_to(:done) }
	it { is_expected.to respond_to(:user_id) }

end
