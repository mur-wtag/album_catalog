# frozen_string_literal: true

class Track < ApplicationRecord
  belongs_to :album
  validates :title, :duration, presence: true
end
