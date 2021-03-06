Rails.application.routes.draw do
  post 'devices/add', to: 'devices#add'
  post 'devices/allow', to: 'devices#allow'
  post 'devices/deny', to: 'devices#deny'
  post 'devices/edit', to: 'devices#edit'
  post 'devices/delete', to: 'devices#delete'
  get  'devices/show', to: 'devices#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'
end
