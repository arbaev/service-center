# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'client/home#index'

  devise_for :staffs, controllers: { sessions: 'staff/sessions' }
  devise_for :clients, controllers: { sessions: 'client/sessions' }

  namespace :staff do
    get :user, to: 'staff#user'

    resources :home, only: :index do
      get :user, on: :collection
    end
  end

  namespace :client do
    get :user, to: 'client#user'

    resources :home, only: %i[index create] do
      get :user, on: :collection
    end
  end
end
