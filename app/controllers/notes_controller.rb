class NotesController < ApplicationController
   before_action :user_owns_note, only: [:destroy]
   def create
      @note = Note.new(params.require(:note).permit(:content, :track_id))
      @note.user = current_user      
      flash[:errors] = @note.errors.full_messages unless @note.save
      redirect_to track_url(@note.track)
   end

   def destroy
      @note ||= Note.find_by_id(params[:id])
      @note.destroy
      redirect_to track_url(@note.track)
   end

   private
   def user_owns_note
      @note = Note.find_by_id(params[:id])
      unless @note.user_id == current_user.id
         render plain: "You cannot delete other users' notes!", status: :forbidden
      end
   end


end