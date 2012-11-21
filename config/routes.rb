MongoBlog::Application.routes.draw do
  
  devise_for :users, 
  	:path => "",
  	:path_names => { :sign_in => 'login', :sign_out => 'logout' },
  	:controllers => { :sessions => :sessions },
  	:skip => [:passwords, :registrations]

  root :to => "home#index"

  namespace :cpanel do
  	root :to => "home#index"
  	resources :categories, :except => [:show] do
      get 'search', :on => :collection
      post 'destroies', :on => :collection
    end
    resources :posts do
      get 'search', :on => :collection
      post 'destroies', :on => :collection
    end
    resources :albums do
      get 'search', :on => :collection
      get 'page/:page', :action => :index, :on => :collection
      resources :photos do
        get 'page/:page', :action => :index, :on => :collection
      end
    end
  end
  resources :categories
  resources :posts
end
