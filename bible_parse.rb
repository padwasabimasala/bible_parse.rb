def parse(line)
  res = {}
  m = line.match /Book (\d{2}) ([\d\-\w]+) (\d+):(\d+) (.*)/
  return if m.nil?

  res[:booknum] = m[1].to_i
  res[:bookname] = m[2]
  res[:chapternum] = m[3].to_i
  res[:versenum] = m[4].to_i
  if res[:versenum] > 0
    res[:versetext] = m[5]
  else
    res[:chaptertitle] = m[5]
  end
  res
end

def bible_hash
  bible = {}
  book = []
  chapter = []
  File.open('kjv.txt').each_line do |line|
    res = parse line
    unless res.nil?
      if res[:bookname] =~ /^\d+/
        num,name = res[:bookname].split('-')
        res[:bookname] = name + num
      end
      if res[:bookname] == "Song-of-Solomon"
        res[:bookname] = "SongOfSolomon"
      end
      if res[:chapternum] == 1 && res[:versenum] == 1
        book = [nil]
        bible[res[:bookname].to_sym] = book
      end
      if res[:versenum] == 1
        chapter = [nil]
        book.append(chapter)
      end
      chapter.append(res[:versetext])
    end
  end
  bible
end

pp bible_hash
