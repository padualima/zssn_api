require 'api_constraints'
require 'routing_mapper'
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  scope module: :api, defaults: { format: :json }, path: '/' do
    draw :v1
  end
end
