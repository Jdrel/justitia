Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/video', to: 'pages#video'
  get '/lawyers/:lawyer_id/consultations/new_appointment', to: 'consultations#new_appointment', as: :new_appointment
  post '/lawyers/:lawyer_id/consultations/new_appointment', to: 'consultations#create_new_appointment', as: :create_new_appointment
  get '/lawyers/:lawyer_id/consultations/:id/new_appointment/confirmation', to: 'consultations#confirmation', as: :confirmation


  resources :lawyers, only: [:index, :show, :new] do
    resources :consultations, only: [:index, :new, :create, :show]
  end

  patch '/consultations/:id/appointment_status', to: 'consultations#appointment_status', as: :update_appointment_status
  get '/consultations/:id/end_videocall', to: 'consultations#end_videocall', as: 'end_videocall'
end
