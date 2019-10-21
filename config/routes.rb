# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'index#index'

  devise_for :staffs, controllers: { sessions: 'staff/sessions' }
  devise_for :clients, controllers: { sessions: 'client/sessions' }

  namespace :staff do
    get :user, to: 'staff#user'

    resources :client, only: %i[index create update destroy] do
      post :validation, on: :collection
      post :reset_password, on: :member
    end

    resources :org_type, only: :index
    resources :staff, only: %i[index create update]
    resources :organization, only: %i[index create destroy]
    resources :home, only: :index
  end

  namespace :client do
    get :user, to: 'client#user'

    resources :home, only: :index
  end

  get '/*slug', to: 'staff/home#index'
end
