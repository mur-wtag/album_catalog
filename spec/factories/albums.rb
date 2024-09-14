# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    name { 'My Awesome Album' }
    published_at { nil }
    association :created_by, factory: :user

    trait :published do
      published_at { Time.zone.now }
    end
  end
end
