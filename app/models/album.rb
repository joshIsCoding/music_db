class Album < ApplicationRecord
   validates :title, :year, :album_type, presence: true
   validates :album_type, inclusion: { in: %w(EP LP Compilation) }
   validates :title, uniqueness: {scope: :artist_id }

   belongs_to(
      :artist,
      class_name: "Artist",
      foreign_key: :artist_id,
      primary_key: :id
   )
end
