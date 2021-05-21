Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get '/exam-group/(:format)', to: 'exams#group'
  get '/exam/create', to: 'exams#new'
  post '/exam/create', to: 'exams#create'
  get '/exams/show', to: 'exams#show'
  get '/exams/search', to: 'exams#search'
  get '/exam/detail', to: 'exams#detail'
  post '/exam/detail', to: 'results#show'

  get '/question/create', to: 'questions#new'
  post '/question/create', to: 'questions#create'
  get '/question/search', to: 'questions#index'
  resource :questions
  get 'results', to: 'results#show'
  post 'results', to: 'results#create'

  get 'profile', to: 'static_pages#profile'

  
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
    get "signup" => "devise/"
  end

  # get "*path" => redirect("/")
end
