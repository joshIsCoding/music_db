class Album < ApplicationRecord
   validates :title, :year, :album_type, presence: true
   validates :album_type, inclusion: { in: %w(EP LP Compilation) }
   validates :title, uniqueness: {scope: :band_id }

end
