Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
    resources :clubs
  end

  resources :athletes, except: [:index, :create, :new] do
    resources :clubs do
      post :add_club, on: :member
    end
  end
  root to: 'home#index'
end
