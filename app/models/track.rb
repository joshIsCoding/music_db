class Track < ApplicationRecord
   validates :title, :ord, presence: true
   validates :title, uniqueness: { scope: :album_id }

   belongs_to(
      :album,
      class_name: "Album",
      foreign_key: :album_id,
      primary_key: :id
   )

   has_one :artist, through: :album, source: :artist

end
