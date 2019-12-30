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

   def ugly_lyrics(lyrics)
      ugly_lyrics = ""
      lyrics.each_line do |line| 
         # prepends a music note only if the line contains normal text
         ugly_lyrics += "&#9835; " unless line.match?(/^(\s|\W)+$/)
         ugly_lyrics += h(line) 
      end
      "<pre>#{ugly_lyrics}</pre>".html_safe
   end

end