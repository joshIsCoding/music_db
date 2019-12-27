class BandsController < ApplicationController
   def index
      @bands = Band.all.order(:name)
      render :index
   end

   def show
      @band = Band.find_by_id(params[:id])
      render :show
   end

   def new
      @band = Band.new
      render :new
   end 

   def create
      @band = Band.new(band_params)
      if @band.save
         redirect_to band_url(@band)
      else
         flash.now[:errors] = @band.errors.full_messages
         render :new
      end
   end

   def edit
      @band = Band.find_by_id(params[:id])
      render :edit
   end

   private
   def band_params
      params.require(:band).permit(:name)
   end
end