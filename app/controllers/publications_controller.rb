# frozen_string_literal: true

class PublicationsController < ApplicationController
  before_action :require_login

  def create
    @album = Album.find(params[:album_id])
    authorize @album, :publish?

    @album.publish!
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album published successfully.' }
    end
  end
end
