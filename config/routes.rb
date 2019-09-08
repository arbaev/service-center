Rails.application.routes.draw do
  devise_for :staffs

  root to: 'devise/sessions#new'
end
