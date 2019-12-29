class ArtistsController < ApplicationController
   skip_before_action :require_login, only: :index
   def index
      @artists_album_count = Artist.left_outer_joins(:albums)
      .select("artists.*, COUNT(albums.id) AS album_count")
      .group("artists.id")
      .order(:name)
      render :index
   end

   def show
      @artist = Artist.find_by_id(params[:id])
      render :show
   end

   def new
      @artist = Artist.new
      render :new
   end 

   def create
      @artist = Artist.new(artist_params)
      if @artist.save
         redirect_to artist_url(@artist)
      else
         flash.now[:errors] = @artist.errors.full_messages
         render :new
      end
   end

   def edit
      @artist = Artist.find_by_id(params[:id])
      render :edit
   end

   def update
      @artist = Artist.find_by_id(params[:id])
      if @artist.update_attributes(artist_params)
         redirect_to artist_url(@artist)
      else
         flash.now[:errors] = @artist.errors.full_messages
         render :edit
      end
   end

   def destroy
      @artist = Artist.find_by_id(params[:id])
      @artist.destroy
      redirect_to artists_url
   end

   private
   def artist_params
      params.require(:artist).permit(:name)
   end
end