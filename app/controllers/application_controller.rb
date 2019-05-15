class ApplicationController < ActionController::API

	include Authenticable

	# Exemplo de um current user
	# def current_user
	# 	User.find(1)
	# end

end

# aqui pode ser implementado alguns metodos que serao visiveis por 
# qlqr outra classe que´é visivel do application controller.