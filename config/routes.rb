Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/video', to: 'pages#video'

  resources :lawyers, only: [:index, :show]

  resources :lawyers do
    resources :consultations, only: [:index]
  end

  # patch 'consultations/:id/approve', to: 'consultations#approve', as: :approve_consultation
  # patch 'consultations/:id/reject', to: 'consultations#reject', as: :reject_consultation
  # get 'consultations/:lawyer_id', to: 'consultations#lawyer', as: :consultations_for_lawyer
end
