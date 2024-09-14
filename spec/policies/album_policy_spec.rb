# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

RSpec.describe AlbumPolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:album) { create(:album, created_by: user, published_at: nil) }
  let(:published_album) { create(:album, created_by: user, published_at: Time.zone.now) }

  subject { described_class }

  permissions :index? do
    it 'allows access to everyone' do
      expect(subject).to permit(nil, album) # Guests
      expect(subject).to permit(user, album) # Logged-in users
    end
  end

  permissions :new?, :create? do
    it 'denies access to guests' do
      expect(subject).not_to permit(nil, album)
    end

    it 'allows access to logged-in users' do
      expect(subject).to permit(user, album)
    end
  end

  permissions :edit?, :update?, :destroy?, :publish? do
    context 'when the user is the creator of the album' do
      it 'allows access if the album is not published' do
        expect(subject).to permit(user, album)
      end

      it 'denies access if the album is published' do
        expect(subject).not_to permit(user, published_album)
      end
    end

    context 'when the user is not the creator of the album' do
      it 'denies access' do
        expect(subject).not_to permit(other_user, album)
        expect(subject).not_to permit(other_user, published_album)
      end
    end

    context 'when there is no logged-in user' do
      it 'denies access' do
        expect(subject).not_to permit(nil, album)
        expect(subject).not_to permit(nil, published_album)
      end
    end
  end

  describe 'Scope' do
    let!(:public_album) { create(:album, published_at: Time.zone.now) }
    let!(:private_album) { create(:album, created_by: user, published_at: nil) }

    it 'shows only published albums to guests' do
      resolved_scope = AlbumPolicy::Scope.new(nil, Album).resolve
      expect(resolved_scope).to include(public_album)
      expect(resolved_scope).not_to include(private_album)
    end

    it 'shows only the user\'s own albums if logged in' do
      resolved_scope = AlbumPolicy::Scope.new(user, Album).resolve
      expect(resolved_scope).to include(private_album)
      expect(resolved_scope).not_to include(public_album)
    end
  end
end
