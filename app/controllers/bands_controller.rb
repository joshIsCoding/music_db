class BandsController < ApplicationController
   def index
      @bands = Band.all.order(:name)
      render :index
   end

   def show
      @band = Band.find_by_id(params[:id])
      render :show
   end
end