# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    title { 'Track 1' }
    artist { 'Artist 1' }
    duration { 180 }
    association :album
  end
end
