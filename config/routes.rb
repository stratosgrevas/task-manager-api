require "api_version_constraint"

Rails.application.routes.draw do

  # devise_for :users, cria algumas rotas. Muito útil para criar
  # rotas de usuários.
  # devise_for :users (pode dar conflito com as rotas dos testes)
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # BOAS PRÁTICAS
  # '' => aspsas simples, para string simples
  # "" => aspas duplas, para quando tem concatenação de strings e variáveis.
  
  # namespace é para agrupar e organizar melhor os nossos controllers
  # por exemplo: todos os controllers, que fazem parte da api, eu vou agrupar dentro da pasta
  # api. e nesse caso é preciso criar essa rota em namespace.
  # Poderia ser uma pasta chamada ADMIN. E dentro dela teria controllers que seriam
  # para controlar coisas do amin.
  namespace :api, defaults: { format: :json }, path: '/' do
  	namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
      #resources :tasks
  		resources :users, only: [:show]
  	end
  end
end

############
#
# CONFIGURAÇÃO PARA SUBDOMINIO NO SERVIDOR (LOCAL NÃO FUNCIONA!!!):
# 
# api = www.site.com/api/tasks
# tasks = nome do controller
# constraints (restrições)
# subdomain = api = api.site.com/tasks
# 
# como o path = "/", então o subdominio = api.site.com/tasks
# 
# trabalhar com subdominio é melhor para trabalhar com os DNS do servidor.
# 
# OBS: api.localhost:3000 (não funciona!!!)
# 
# essa alteração, fica num arquivo que só pode ser alterado como administrador!!!
# 
# namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: "/" do
# end
# 
# 
############# 
