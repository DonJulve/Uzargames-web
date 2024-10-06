Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


 

  get "up" => "rails/health#show", as: :rails_health_check
  get "/", to: 'index#index'
  get "/login", to: 'sesion#index'
  get '/signup', to: 'sesion#new'
  post '/signup', to: 'sesion#register'



  get '/user/login', to: 'sesion#login'
  get '/logout', to: 'sesion#logout'

  get "/admin", to: 'admins#index'

  get "/admin/redactores", to: 'admins#redactores'
  post "/admin/redactores/add", to: 'admins#redactores_add'
  post "/admin/redactores/remove", to: 'admins#redactores_remove'

  get "/admin/reportes", to: 'admins#reportes'

  get "/admin/noticias", to: 'admins#noticias'
  post "/admin/noticias/add", to: 'admins#noticias_add'
  post "/admin/noticias/remove", to: 'admins#noticias_remove'

  get "/admin/criticas", to: 'admins#criticas'
  post "/admin/criticas/add", to: 'admins#criticas_add'
  post "/admin/criticas/remove", to: 'admins#criticas_remove'

  get "/admin/admins", to: 'admins#admins'
  post "/admin/admins/add", to: 'admins#admins_add'
  post "/admin/admins/remove", to: 'admins#admins_remove'


  get "/buscador", to: 'buscador#index'


  get "/noticia/redactar", to: 'noticia#redactar_noticia'
  get "/noticia/:titulo", to: 'noticia#index'
  post '/noticia/upload', to: 'noticia#upload_new'
  

  post '/noticia/:titulo/postcomment/:id_usuario', to: 'comentario#addComent'

  post '/noticia/:titulo/postreview/:id_usuario', to: 'valoracion#addReview'


  get "/error", to: 'error#index'
  post "/error", to: 'error#index'

  match '*path', to: 'error#index', via: :all, status: 404

  # Defines the root path route ("/")
  # root "posts#index"
end
