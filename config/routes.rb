Rails.application.routes.draw do
  get '/stream', to: 'application#stream'
  root to: 'application#homepage'
end
