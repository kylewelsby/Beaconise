class BusinessesController < ApplicationController
	before_filter :authenticate_business!
  def dashboard
  end

end
