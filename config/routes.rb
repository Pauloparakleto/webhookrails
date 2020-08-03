Rails.application.routes.draw do
  post "webhook/", to: 'webhook#receiver'

  get 'issues/', to: 'issues#index'
  get 'issues/:id', to: 'issues#show'
  resources :issue do
    resources :events, only: [:index, :show]
  end
  resources :events, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
