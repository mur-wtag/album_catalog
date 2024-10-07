# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  let(:user) { create(:user) }
  let(:album) { create(:album, created_by: user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:require_login).and_return(true)
  end

  describe 'POST #create' do
    it 'publishes the album and redirects to index' do
      post :create, params: { album_id: album.id }
      album.reload
      expect(album.published_at).to be_present
      expect(response).to redirect_to(albums_url)
      expect(flash[:notice]).to eq('Album published successfully.')
    end
  end
end
