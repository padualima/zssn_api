require 'api_constraints'
require 'routing_mapper'
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  draw :v1

  root 'v1/reports#stats'
end
