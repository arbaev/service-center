Rails.application.routes.draw do
  root to: 'client/home#index'

  devise_for :staffs, controllers: { sessions: 'staff/sessions' }
  devise_for :clients, controllers: { sessions: 'client/sessions' }

  namespace :staff do
    resources :home, only: :index do
      get :user, on: :collection
    end
  end

  namespace :client do
    resources :home, only: %i[index create] do
      get :user, on: :collection
    end
  end
end
