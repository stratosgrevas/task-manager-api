Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # namespace é para agrupar e organizar melhor os nossos controllers
  # por exemplo: todos os controllers, que fazem parte da api, eu vou agrupar dentro da pasta
  # api. e nesse caso é preciso criar essa rota em namespace.
  # Poderia ser uma pasta chamada ADMIN. E dentro dela teria controllers que seriam
  # para controlar coisas do amin.
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: "/" do

  end
end

# api = www.site.com/api/tasks
# tasks = nome do controller
# constraints (restrições)
# subdomain = api = api.site.com/tasks
# 
# como o path = "/", então o subdominio = api.site.com/tasks
# 
# trabalhar com subdominio é melhor para trabalhar com os DNS do servidor.
