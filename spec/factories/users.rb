# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "user_#{(Time.now.to_f * 1000).to_i}@example.com" }
    password { 'password123' }
  end
end
