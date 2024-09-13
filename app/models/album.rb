# frozen_string_literal: true

class Album < ApplicationRecord
  has_one_attached :cover_image

  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true

  validates :name, presence: true

  scope :published, -> { where(published: true) }

  def publish!
    update!(published: true)
  end

  def unpublish!
    update!(published: false)
  end

  def published?
    published
  end
end
