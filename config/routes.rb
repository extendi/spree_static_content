Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :pages
  end
  get '/page/*slug', :to => 'static_content#show', :as => 'static'
end
