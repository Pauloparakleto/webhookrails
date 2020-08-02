Rails.application.routes.draw do
  post "webhook/", to: 'webhook#receiver'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
