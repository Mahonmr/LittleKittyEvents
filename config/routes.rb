Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
    resources :clubs
  end

  namespace :manager do
    resources :clubs do
    end
  end

  namespace :athlete do
    resources :clubs do
      post :add_club, on: :member
    end
  end

  get "home/admin", as: 'admin_home'
  get "home/athlete", as: 'athlete_home'

  root to: 'home#index'
end
