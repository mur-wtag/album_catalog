# frozen_string_literal: true

# reset DB first
ActiveRecord::Base.connection.tables.each do |table|
  unless %w[ar_internal_metadata schema_migrations].include?(table)
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
  end
end

# Load seed data
user = UserFactory.create(
  email: 'user@example.com',
  password: 'password'
)

other_user = UserFactory.create(
  email: 'other_user@example.com',
  password: 'password'
)

album = AlbumFactory.create(
  created_by: user,
  name: 'Happier Than Ever',
  tracks_attributes: [
    {
      title: 'Getting Older',
      artist: 'Billie Eilish',
      duration: 244
    },
    {
      title: 'Oxytocin',
      artist: 'Billie Eilish',
      duration: 210
    },
    {
      title: 'My Future',
      artist: 'Billie Eilish',
      duration: 210
    }
  ]
)

album.cover_image.attach(
  io: File.open(Rails.root.join('db/cover_images/happier_than_ever.png')),
  filename: 'happier_than_ever.png'
)

AlbumFactory.create(
  created_by: user,
  name: 'Dont smile at me'
)

album2 = AlbumFactory.create(
  created_by: user,
  name: 'Born to Die',
  published_at: Time.zone.now,
  tracks_attributes: [
    {
      title: 'Born to Die',
      artist: 'Lana Del Rey',
      duration: 287
    },
    {
      title: 'Blue Jeans',
      artist: 'Lana Del Rey',
      duration: 210
    },
    {
      title: 'Dark Paradise',
      artist: 'Lana Del Rey',
      duration: 244
    }
  ]
)

album2.cover_image.attach(
  io: File.open(Rails.root.join('db/cover_images/born_to_die.png')),
  filename: 'born_to_die.png'
)

album3 = AlbumFactory.create(
  created_by: other_user,
  published_at: Time.zone.now,
  name: 'Optimist',
  tracks_attributes: [
    {
      title: 'Only a lifetime',
      artist: 'FINNEAS',
      duration: 257
    },
    {
      title: 'Love is pain',
      artist: 'FINNEAS',
      duration: 224
    }
  ]
)

album3.cover_image.attach(
  io: File.open(Rails.root.join('db/cover_images/optimist.png')),
  filename: 'optimist.png'
)

AlbumFactory.create(
  created_by: other_user,
  name: 'Life inside out'
)
