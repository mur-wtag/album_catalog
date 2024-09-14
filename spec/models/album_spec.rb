# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
    it { should have_one_attached(:cover_image) }
    it { should have_many(:tracks).dependent(:destroy) }
    it { should belong_to(:created_by).class_name('User').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'nested attributes' do
    it 'should accept nested attributes for tracks' do
      should accept_nested_attributes_for(:tracks).allow_destroy(true)
    end
  end

  describe 'scopes' do
    let!(:album_published) { create(:album, published_at: Time.zone.now) }
    let!(:album_unpublished) { create(:album, published_at: nil) }

    describe '.published' do
      it 'returns albums that are published' do
        expect(Album.published).to include(album_published)
        expect(Album.published).not_to include(album_unpublished)
      end
    end
  end

  describe '#publish!' do
    let(:album) { create(:album, published_at: nil) }

    it 'sets the published_at to the current time' do
      freeze_time do
        album.publish!
        expect(album.published_at).to eq(Time.zone.now)
      end
    end
  end

  describe '#published?' do
    let(:album) { build(:album, published_at: Time.zone.now) }

    it 'returns true if published_at is present' do
      expect(album.published?).to be true
    end

    it 'returns false if published_at is nil' do
      album.published_at = nil
      expect(album.published?).to be false
    end
  end

  describe '#total_album_duration' do
    let(:album) { create(:album) }
    let!(:track1) { create(:track, album: album, duration: 180) } # 3 minutes
    let!(:track2) { create(:track, album: album, duration: 240) } # 4 minutes

    it 'returns the total duration of all tracks in the album' do
      expect(album.total_album_duration).to eq(420) # 7 minutes in seconds
    end
  end
end

