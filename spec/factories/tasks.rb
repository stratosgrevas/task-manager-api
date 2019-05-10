FactoryGirl.define do 
	factory :task do
		title { Faker::Lorem.sentence }
		description { Faker::Lorem.paragraph }
		deadline { Faker::Date.forward } # data futura
		done false
		# desta forma, o FactoryGirl automaticamente pega um usuário do faker de usuarios!
		# Mas outra opção é usar: 
		# user_id "1"
		# Que irá criar um usuário com o id = 1
		user
	end
end