class PromotersController < ApplicationController
  def index
    @promoters = Promoter.find(:all)
    respond_to do |format|
      format.html 
      format.xml { render :xml => @promoters }
    end
  end

  def show
    @promoter = Promoter.find_by_permalink(params[:id])
    respond_to do |format|
      format.html 
      format.xml { render :xml => @promoter }
    end
  end

  def new
    @promoter = Promoter.new(params[:promoter])
    respond_to do |format|
      format.html 
      format.xml { render :xml => @promoter }
    end
  end
  
  def create
    @promoter = Promoter.new(params[:promoter])
    respond_to do |format|
      if @promoter.save
        format.html { redirect_to promoter_path(@promoter) }
        format.xml  { render :xml => @promoter, :status => :created, :location => @promoter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @promoter.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @promoter = Promoter.find_by_permalink(params[:id])
  end

  def update
    @promoter = Promoter.find_by_permalink(params[:id])
    respond_to do |format|
      if @promoter.update_attributes(params[:promoter])
        flash[:success] = "Updated Photo Successfully" 
        format.html { redirect_to promoter_path(@promoter) }
        format.xml { head :ok }
      else
        format.html { render :edit }
        format.xml { render :xml => @promoter.errors, :status => :unprocessable_entry}
      end
    end
  end
  
  def destroy
    @promoter = Promoter.find_by_permalink(params[:id])
    @promoter.destroy
    respond_to do |format|
      format.html { redirect_to promoters_path }
      format.xml { head :ok }
    end
  end
end
