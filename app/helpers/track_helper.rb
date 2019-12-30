module TrackHelper
   def lyric_trim(lyrics, length=30)
      trimmed = lyrics[0..length]
      # use semi-colons to signify linebreaks in snippet preview
      trimmed.gsub!(/(\n|\r|\r\n)+/, "; ")
      if trimmed.length > length
         # trims until a word character is found
         trimmed.chop! until trimmed.match?(/.*?\w$/)
         trimmed += "..."
      end
      trimmed
   end

end