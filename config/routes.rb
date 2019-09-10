Rails.application.routes.draw do
  root to: 'user/home#index'

  namespace :admin do
    devise_for :staffs, controllers: {
        sessions: 'admin/sessions'
    }

    get 'home/index'
  end

  namespace :user do
    devise_for :clients, controllers: {
        sessions: 'user/sessions'
    }

    get 'home/index'
  end

end
