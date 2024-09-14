# frozen_string_literal: true

class Album < ApplicationRecord
  has_one_attached :cover_image

  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true

  validates :name, presence: true

  scope :published, -> { where.not(published_at: nil) }

  def publish!
    update!(published_at: Time.zone.now)
  end

  def published?
    published_at.present?
  end

  def total_album_duration
    tracks.sum(:duration)
  end
end
