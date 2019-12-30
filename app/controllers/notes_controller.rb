class NotesController < ApplicationController
   def create
      @note = Note.new(params.require(:note).permit(:content, :track_id))
      @note.user = current_user      
      flash[:errors] = @note.errors.full_messages unless @note.save
      redirect_to track_url(@note.track)
   end

end