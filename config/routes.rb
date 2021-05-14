Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/profile', to: 'sessions#profile'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  resource :users
  get '/signup', to: 'users#new'

  get '/exam-group/(:format)', to: 'exams#group'
  get '/exam/create', to: 'exams#new'
  post '/exam/create', to: 'exams#create'

  get '/question/create', to: 'questions#new'
  post '/question/create', to: 'questions#create'

  # get "*path" => redirect("/")
end
