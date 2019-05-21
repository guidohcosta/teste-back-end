Rails.application.routes.draw do
  namespace :v1 do
    resources :contacts, param: :email
    resources :visits, only: %i(create index)
  end
end
