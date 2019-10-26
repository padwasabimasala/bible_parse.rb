require 'set'

class Bible
  def initialize
    parse
  end

  def chapters
    @chapters
  end

  def parse
    @chapters = Set[]
    text.each do |line|
      chapter = parse_line line
      @chapters.add(chapter)
    end
  end

  def parse_line(line)
    m = line.match /Book \d{2} (?<chapter>\d?-?\w+).*/
    return m['chapter']
  end

  def text
    File.open('kjv.txt')
  end

end

bible = Bible.new
print bible.chapters
