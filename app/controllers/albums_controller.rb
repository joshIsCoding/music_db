class AlbumsController < ApplicationController
   def show
      @album = Album.find_by_id(params[:id])
      @artist = @album.artist
      render :show
   end

   def new
      @album = Album.new(artist_id: params[:artist_id])
      @artists = Artist.all
      render :new
   end
end