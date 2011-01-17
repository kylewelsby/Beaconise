ActionController::Routing::Routes.draw do |map|
  map.devise_for :admins
	map.devise_for :promoters
	map.devise_for :businesses, :as => :business
	map.devise_for :users
	map.business_root '/business', :controller => :businesses, :action => :dashboard
	map.promoter_root '/promoter', :controller => :promoters, :action => :dashboard
  map.user_root '/dashboard', :controller => :users, :action => :dashboard
	
	
  # Dynamic Profiles
  map.resources :venues, :as => "venue", :collection => { :search => :get}, :member => {:contact => :get, :sync => :get, :details => :get, :map => :get, :connect => :get, :delete => :get} do |venue|
    venue.resources :photos
    venue.resources :events, :member => {:acts => :get, :remove_act => :delete, :attending => :any, :rsvp => :any, :sync => :get, :flag => :get, :delete => :get} do |event|
			event.resources :acts, :member => {:importance => [:get, :post]}
      event.resources :photos
    end
  end
  map.connect "/venue/:id/:action", :controller => "venues"

  map.resources :promoters, :as => "promoter" do |promoter|
    promoter.resources :events do |event|
      event.resources :photos
    end
  end
  map.connect "/promoter/:id/:action", :controller => "promoters"
  
  map.resources :users, :as => "user", :collection => {:autocomplete_for_user_name => :get}, :member => {  :details => :get} do |user|
    user.resources :photos
    # user.resources :messages, :collection => {
    #     :destroy_selected => :post,
    #     :inbox => :get,
    #     :outbox => :get,
    #     :trashbin => :get
    #   },
    #   :member => {:reply => :get}
    user.resources :galleries do |gallery|
      gallery.resources :photos, :as => "photo"
    end

    # user.resources :events
  end
  # map.connect "/user/:id/:action", :controller => "users"
  
  map.resources :messages,  :collection => {
      :destroy_selected => :post,  
      :inbox            => :get,  
      :outbox           => :get,  
      :trashbin         => :get
    },  
    :member => {:reply => :get}
  
  # Indexes
  map.resources :artists, :collection => {:search => :get}
  map.resources :events, :only => [:index, :new, :create]
  map.resources :promoters, :only => [:index, :new, :create]
  map.resources :venues, :only => [:index, :new, :create]
  # map.users "/users", :controller => "venues", :action => "index"
  map.members "/members", :controller => "users", :action => "index"
  map.photos "/photos", :controller => "photos", :action => "index"

  map.resources :comments
  
  # Login & Sign Up
  # map.resource :user_session
  # map.login "/login", :controller => "user_sessions", :action => "new"
  # map.logout "/logout", :controller => "user_sessions", :action => "destroy"
  # map.signup "/signup", :controller => "users", :action => "new"
  map.resource :account, :controller => "users"
  # map.resource :reset_password, :controller => "user_password"
  
  # Homepage, Legal & About
  map.root :controller => "about", :action => "homepage"
  map.resource :about

  map.terms '/', :controller => "about", :action => "homepage"
  map.careers '/', :controller => "about", :action => "homepage"
  map.developers '/', :controller => "about", :action => "homepage"
  map.advertising '/', :controller => "about", :action => "homepage"
  map.support '/support', :controller => "about", :action => "show"
  # Defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
	map.connect ':controller/:action.:format'
end
