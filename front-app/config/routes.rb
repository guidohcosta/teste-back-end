Rails.application.routes.draw do
  get 'visits/index'
  get 'sobre' => 'high_voltage/pages#show', id: 'sobre'
  resources :contacts, only: %i(new create)
end
