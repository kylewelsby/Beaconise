# encoding: utf-8

ActionController::Routing::RouteSet::Mapper.class_eval do

  protected

    # Setup routes for +FacebookSessionsController+.
    #
		def facebook_authenticatable
			routes.with_options(:controller => 'facebook_auth', :name_prefix => nil) do |auth|
	      auth.send(:"new_#{mapping.name}_session", mapping.path_names[:sign_in], :action => 'create', :conditions => {:method => :get})
	      # auth.send(:"#{mapping.name}_session", mapping.path_names[:sign_in], :action => 'create', :conditions => {:method => :post})
	      # auth.send(:"destroy_#{mapping.name}_session", mapping.path_names[:sign_out], :action => 'destroy', :conditions => { :method => :get })
			end
		end
    alias :facebook :database_authenticatable

end