Rails.application.routes.draw do
  get 'devices/add'
  get 'devices/allow'
  get 'devices/deny'
  get 'devices/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'
end
