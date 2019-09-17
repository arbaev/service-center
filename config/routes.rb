Rails.application.routes.draw do
  root to: 'client/home#index'

  devise_for :staffs, controllers: { sessions: 'staff/sessions' }
  devise_for :clients, controllers: { sessions: 'client/sessions' }

  namespace :staff do
    get 'home/index'
  end

  namespace :client do
    get 'home/index'
  end
end
