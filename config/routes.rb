require 'api_constraints'
require 'routing_mapper'

Rails.application.routes.draw do
  scope module: :api, defaults: { format: :json }, path: '/' do
    draw :v1
  end
end
