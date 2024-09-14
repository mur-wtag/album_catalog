# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'associations' do
    it { should belong_to(:album) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:duration) }
  end
end
