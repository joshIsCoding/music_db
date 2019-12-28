class AlbumsController < ApplicationController
   def show
      @album = Album.find_by_id(params[:id])
      @artist = @album.artist
      render :show
   end

end