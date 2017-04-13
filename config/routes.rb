Rails.application.routes.draw do
  root 'pages#dashboard'

  mount ActionCable.server => '/cable'
end
