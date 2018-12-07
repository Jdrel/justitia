Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/video', to:'pages#video'

  resources :lawyers, only: [:index, :show] do
    resources :consultations, only: [:new, :create, :show]
  end

  get '/consultations/:id/end_videocall', to: 'consultations#end_videocall', as: 'end_videocall'
end
