Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :clubs do
      post :add_club, on: :member
    end
  end

  root :to => 'clubs#index'
end
