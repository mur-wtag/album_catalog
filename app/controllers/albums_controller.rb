# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show edit update destroy]
  before_action :ensure_frame_response, only: %i[new edit]

  # GET /albums or /albums.json
  def index
    @albums = Album.all.order(published_at: :desc, created_at: :desc)
  end

  # GET /albums/1 or /albums/1.json
  def show; end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit; end

  # album /albums or /albums.json
  def create
    @album = Album.new(album_params)
    respond_to do |format|
      if @album.save
        format.turbo_stream { render turbo_stream: turbo_stream.action(:refresh, "") }
        format.html { redirect_to album_url(@album), notice: "Album was successfully created." }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.turbo_stream { render turbo_stream: turbo_stream.action(:refresh, "") }
        format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  def ensure_frame_response
    return unless Rails.env.development?
    redirect_to root_path unless turbo_frame_request?
  end

  def album_params
    params
      .require(:album)
      .permit(
        :name,
        :cover_image,
        tracks_attributes: %i[id title artist duration _destroy]
      )
  end
end
