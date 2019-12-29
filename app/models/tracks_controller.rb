class TracksController < ApplicationController
   def show
      @track = Track.find_by_id(params[:id])
      render :show
   end

   def new
      @track = Track.new(album_id: params[:album_id])
      render :new
   end

   def create
      @track = Track.new(track_params)
      if @track.save
         redirect_to track_url(@track)
      else
         flash.now[:errors] = @track.errors.full_messages
         render :new
      end
   end

   def edit
      @track = Track.find_by_id(params[:id])
      render :edit
   end   

   private
   def track_params
      params.require(:track).permit(:title, :album_id, :ord, :lyrics, :bonus?)
   end
end