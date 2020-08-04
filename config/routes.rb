Rails.application.routes.draw do
  post "webhook/", to: 'webhook#receiver'

  get 'issue/', to: 'issues#index'
  get 'issues/', to: 'issues#index'
  get 'issue/:id', to: 'issues#show'
  get 'issues/:id', to: 'issues#show'

  get 'issue/:issue_id/event/', to: 'events#index'
  get 'issue/:issue_id/events/', to: 'events#index'
  get 'issues/:issue_id/event/', to: 'events#index'
  get 'issues/:issue_id/events/', to: 'events#index'

  get 'issues/:issue_id/event/:id', to: 'events#show'
  get 'issues/:issue_id/events/:id', to: 'events#show'


  resources :issue do
    resources :events, only: [:index, :show]
  end
  resources :events, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
