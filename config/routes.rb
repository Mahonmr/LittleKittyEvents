Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :clubs do
      post :add_club, on: :member
    end
  end

  scope :admin, as: :admin do
    resources :users
  end

  scope "/athlete" do
    resources :clubs
  end

  root :to => 'clubs#index'
end
