scope module: :v1, defaults: { format: :json }, constraints: ApiConstraints.new(version: 1, default: true) do
  resources :survivors, except: %i[index destroy] do
    member do
      get :nearest
    end
  end
end
