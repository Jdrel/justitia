Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/video', to: 'pages#video'

  resources :lawyers, only: [:index, :show] do
    resources :consultations, only: [:index, :new, :create, :show]
  end

  patch 'consultations/:id/appointment_status', to: 'consultations#appointment_status', as: :update_appointment_status
end
