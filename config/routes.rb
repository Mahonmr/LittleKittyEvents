Rails.application.routes.draw do
  resources :clubs

  root :to => 'clubs#index'
end
