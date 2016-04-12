Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :clubs
  resources :event_types
  namespace :admin do
    resources :users
    resources :clubs
    resources :event_types
  end

  namespace :athlete do
    resources :users, only: [:edit, :show, :index]
    resources :clubs do
      post :add_club, on: :member
    end
  end

  get "home/admin", as: 'admin_home'
  get "home/athlete", as: 'athlete_home'

  root to: 'home#index'
end
