class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  filter_parameter_logging :password, :password_confirmation, :fb_sig_friends
  before_filter :mailer_set_url_options
  protect_from_forgery :only => [:create, :update, :destroy]

  private
    def mailer_set_url_options
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
    
    def store_this_location
      session[:return_to_page] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to_page] || default)
      session[:return_to_page] = nil
    end
end
