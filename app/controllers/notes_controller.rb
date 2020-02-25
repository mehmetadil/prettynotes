class NotesController < ApplicationController
  before_action :set_note, only: %i(show edit update destroy)

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html @note, flash: :success
      else
        render :new, alert: @note.errors
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @note.update_attributes(note_params)
        format.html @note, flash: :success
      else
        render :edit, alert: :@note.errors
      end
    end
  end

  def destroy
    respond_to do |format|
      if @note.destroy
        format.html notes_path
      else
        redirect_to :back, alert: @note.errors
      end
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
