# frozen_string_literal: true

class TracksController < ApplicationController
  before_action :set_album
  before_action :set_track, only: %i[show edit update destroy]

  def new
    @track = @album.tracks.build
  end

  def create
    @track = @album.tracks.build(track_params)
    if @track.save
      redirect_to album_path(@album), notice: 'Track created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @track.update(track_params)
      redirect_to album_path(@album), notice: 'Track updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    msg = @track.destroy ? 'Track deleted successfully.' : 'Something went wrong. Track not deleted.'
    redirect_to album_path(@album), notice: msg
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_track
    @track = @album.tracks.find(params[:id])
  end

  def track_params
    params.require(:track).permit(:title, :duration, :artist)
  end
end
