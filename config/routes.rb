Rails.application.routes.draw do
  devise_for :users
  resources :clubs

  root :to => 'clubs#index'
end
