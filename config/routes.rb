Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/video', to: 'pages#video'
  get '/lawyers/:lawyer_id/consultations/new_appointment', to: 'consultations#new_appointment', as: :new_appointment
  post '/lawyers/:lawyer_id/consultations/new_appointment', to: 'consultations#create_new_appointment', as: :create_new_appointment
  get '/lawyers/:lawyer_id/consultations/:id/new_appointment/confirmation', to: 'consultations#appointment_confirmation', as: :appointment_confirmation
  get '/lawyers/stripe', to: 'lawyers#stripe', as: :stripe

  resources :lawyers, only: [:index, :show, :new, :create] do
    resources :consultations, only: [:index, :new, :create, :show]
  end

  patch 'lawyers/:lawyer_id/online', to: 'lawyers#online', as: :online_lawyer
  patch 'lawyers/:lawyer_id/offline', to: 'lawyers#offline', as: :offline_lawyer

  patch '/consultations/:id/appointment_status', to: 'consultations#update_appointment_status', as: :update_appointment_status
  get '/consultations/:id/end_videocall', to: 'consultations#end_videocall', as: 'end_videocall'

  Rails.application.routes.draw do
  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
end
