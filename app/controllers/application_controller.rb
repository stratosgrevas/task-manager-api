class ApplicationController < ActionController::API

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		attrs = [:name]
		devise_parameter_sanitizer.permit(:sign_up, keys: attrs)
		devise_parameter_sanitizer.permit(:account_update, keys: attrs)
	end
    
	# Exemplo de um current user
	# def current_user
	# 	User.find(1)
	# end

end

# aqui pode ser implementado alguns metodos que serao visiveis por 
# qlqr outra classe que´é visivel do application controller.