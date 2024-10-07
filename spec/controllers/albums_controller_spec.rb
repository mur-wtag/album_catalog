# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  let(:user) { create(:user) }
  let(:album) { create(:album, created_by: user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:require_login).and_return(true)
  end

  describe 'GET #index' do
    context 'with guest user' do
      let(:user) { nil }

      it 'assigns @albums with only published records and renders the index template' do
        create(:album, created_by: user)
        create_list(:album, 2, published_at: Time.zone.now, created_by: nil)

        get :index
        expect(assigns(:albums)).to be_present
        expect(assigns(:albums).count).to eq 2
        expect(response).to render_template(:index)
      end
    end

    context 'with signed in user' do
      it 'assigns @albums all published/unpublished albums of current user and renders the index template' do
        create(:album, created_by: user)
        create(:album, created_by: create(:user), published_at: Time.zone.now)
        create_list(:album, 3, published_at: Time.zone.now, created_by: user)

        get :index
        expect(assigns(:albums)).to be_present
        expect(assigns(:albums).count).to eq 4
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new album and renders the new template' do
      get :new

      expect(assigns(:album)).to be_a_new(Album)
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested album and renders the edit template' do
      get :edit, params: { id: album.id }

      expect(assigns(:album)).to eq(album)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new album and redirects to show' do
        expect do
          post :create, params: { album: attributes_for(:album) }
        end.to change(Album, :count).by(1)
        expect(response).to redirect_to(album_url(Album.last))
        expect(flash[:notice]).to eq('Album was successfully created.')
      end
    end

    context 'with invalid params' do
      it 're-renders the new template' do
        post :create, params: { album: attributes_for(:album, name: nil) }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the album and redirects to show' do
        patch :update, params: { id: album.id, album: { name: 'New Album Name' } }
        album.reload

        expect(album.name).to eq('New Album Name')
        expect(response).to redirect_to(album_url(album))
        expect(flash[:notice]).to eq('Album was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 're-renders the edit template' do
        patch :update, params: { id: album.id, album: { name: nil } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the album and redirects to index' do
      album_to_delete = create(:album, created_by: user)
      expect do
        delete :destroy, params: { id: album_to_delete.id }
      end.to change(Album, :count).by(-1)
      expect(response).to redirect_to(albums_url)
      expect(flash[:notice]).to eq('Album was successfully destroyed.')
    end
  end
end
