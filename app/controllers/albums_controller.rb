# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :require_login, except: :index
  before_action :set_album, only: %i[show edit update destroy publish]
  before_action :ensure_frame_response, only: %i[new edit]

  # GET /albums or /albums.json
  def index
    authorize :album, :index?
    scope = policy_scope(Album).includes(:tracks)
    @albums = scope.paginate(page: params[:page], per_page: 10)
                   .order(published_at: :asc, id: :desc)
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
  # rubocop:disable Metrics/AbcSize
  def create
    @album = Album.new(album_params)
    @album.created_by = current_user

    respond_to do |format|
      if @album.save
        flash.now[:notice] = "#{@album.name} was successfully created."
        # to refresh whole list
        # format.turbo_stream { render turbo_stream: turbo_stream.action(:refresh, '') }

        # To make flash message work in turbo, I have followed these solutions (I know it's not kind of good practice)
        # TODO: move flash messages in JS
        # https://discuss.hotwired.dev/t/flash-messages-with-turbo/2345/14
        # https://hivekind.com/blog/exploring-flash-messages-with-turbo-streams-in-rails-7

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              'albums',
              partial: 'albums/album',
              locals: { album: @album }
            ),
            turbo_stream.replace('flash', partial: 'application/flash')
          ]
        end
        format.html { redirect_to album_url(@album), notice: 'Album was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        flash.now[:notice] = "#{@album.name} was successfully updated."

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @album,
              partial: 'albums/album',
              locals: { album: @album }
            ),
            turbo_stream.replace('flash', partial: 'application/flash')
          ]
        end
        format.html { redirect_to album_url(@album), notice: 'Album was successfully updated.' }
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
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish
    @album.publish!

    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album published successfully.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = policy_scope(Album).find(params[:id])
    authorize @album, "#{action_name}?".to_sym
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
