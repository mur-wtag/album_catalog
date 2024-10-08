# frozen_string_literal: true

class AlbumFactory
  def self.build(attributes = {})
    Album.new({
      name: "Album #{(Time.now.to_f * 1000).to_i}"
    }.merge(attributes))
  end

  def self.create(attributes = {})
    build(attributes).tap(&:save!)
  end
end
