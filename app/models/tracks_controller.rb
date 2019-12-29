class TracksController < ApplicationController
   def show
      @track = Track.find_by_id(params[:id])
      render :show
   end
end