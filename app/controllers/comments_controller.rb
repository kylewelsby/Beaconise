class CommentsController < ApplicationController
  def show
    @comment = Comment.find_by_id(params[:id])
    redirect_back_or_default(account_path)
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash.now[:success] = "Comment successfully posted."
        if session[:return_to_page]
          format.html { redirect_back_or_default(account_path) }
        else
          format.html { render :partial => @comment } if request.xhr?
        end
        format.xml { render :xml => @comment.to_xml }
        format.js
      else
        flash.now[:error] = "Comment failed to post" 
      end
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    render :nothing if @comment.nil?
    if owner_or_admin(@comment)
      respond_to do |format|
        if @comment.destroy
          flash.now[:success] = "Comment successfully removed" 
          format.html { redirect_back_or_default(account_path) }
          format.js
        else
          flash.now[:error] = "Failed to remove comment" 
        end
      end
    end
  end
end
