class TracksController < ApplicationController
   def show
      @track = Track.find_by_id(params[:id])
      render :show
   end

   def new
      @track = Track.new(album_id: params[:album_id])
      render :new
   end
end