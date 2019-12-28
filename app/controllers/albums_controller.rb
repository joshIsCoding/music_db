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

   def create
      @album = Album.new(album_params)
      if @album.save
         redirect_to album_url(@album)
      else
         flash.now[:errors] = @album.errors.full_messages
         @artists = Artist.all
         render :new
      end
   end

   private
   def album_params
      params.require(:album).permit(:title, :artist_id, :year, :album_type, :live?)
   end
end