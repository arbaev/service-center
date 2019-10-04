# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'index#index'

  devise_for :staffs, controllers: { sessions: 'staff/sessions' }
  devise_for :clients, controllers: { sessions: 'client/sessions' }

  namespace :staff do
    get :user, to: 'staff#user'

    resources :client, only: %i[index create] do
      post :validation, on: :collection
    end
    resources :organization, only: :index
    resources :home, only: :index
  end

  namespace :client do
    get :user, to: 'client#user'

    resources :home, only: :index
  end
end
