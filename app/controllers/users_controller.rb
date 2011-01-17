class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:dashboard]
  
  def live_search
    @users = User.find(:all, :conditions => ['name LIKE ? surname LIKE ?', params[:q], params[:q]], :order => "name ASC, surname ASC", :limit => 8)
    render :layout => false
  end
  
  def index
    @users = User.find(:all, :order => "current_sign_in_at DESC")
  end
  
  def show
    @user = User.find_by_permalink(params[:id]) || current_user
    render :template => "shared/errors/non_existent_or_suspended_user" unless @user
  end

	def dashboard
		
	end
	
	def fb_connect
		
	end
  
end
