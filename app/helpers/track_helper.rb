module TrackHelper
   def lyric_trim(lyrics)
      trimmed = lyrics[0..25]
      if trimmed.length > 25
         trimmed.chop! until trimmed.last.match?(/\w/)
         trimmed += "..."
      end
      trimmed
   end
   
end