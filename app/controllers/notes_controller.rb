class NotesController < ApplicationController
    before_action :logged_in_user
  
    def new
      @note = Note.new
    end
  
    #List of the notes of the user
    def index
      @user = User.find(params[:user_id]) 
      @notes = @user.notes.all
    end
  
    #Create new notes for the user
    def create
      @note = current_user.notes.build(note_params)
      if @note.save
        flash[:success] = "note has been created!"
        redirect_to user_note_path(id: @note.id)
      else
        render 'new'
      end
    end
  
    #Edit existing note of the user
    def edit
      @note = current_user.notes.find(params[:id])
    end
  
    #Update existing note of the user
    def update
      @note = current_user.notes.find(params[:id])
      if @note.update_attributes(note_params)
        flash[:success] = "note updated"
        redirect_to @note
      else
        render 'edit'
      end
    end
  
    #Display note
    def show
      @user = User.find(params[:user_id]) 
      @note = @user.notes.find(params[:id])
    end
  
    private
  
    def note_params
      params.require(:note).permit(:title,:body,:tag)
    end
  
end
