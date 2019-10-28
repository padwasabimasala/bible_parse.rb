require "test/unit"

def parse(line)
  res = {}
  m = line.match /book (\d{2}) ([\d\-\w]+) (\d+):(\d+) (.*)/
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

class testparse < test::unit::testcase
  def test_booknum
    assert_equal 1, _parsed[:booknum]
  end

  def test_bookname
    assert_equal "genesis", _parsed[:bookname]
  end

  def test_chapternum
    assert_equal 1, _parsed[:chapternum]
  end

  def test_versenum
    assert_equal 1, _parsed[:versenum]
  end

  def test_versetext
    assert_equal "in the beginning god created the heaven and the earth.", _parsed[:versetext]
    assert_equal nil, _parsed[:chaptertitle]
  end

  def test_bookname_with_number
    assert_equal "1-samuel", _parsed2[:bookname]
  end

  def test_versenum_of_chapter_title
    assert_equal 0, _parsed2[:versenum]
  end

  def test_chaptertitle
    assert_equal nil, _parsed2[:versetext]
    assert_equal "the birth of samuel", _parsed2[:chaptertitle]
  end

  def _parsed
    line = "book 01 genesis 001:001 in the beginning god created the heaven and the earth."
    parse line
  end

  def _parsed2
    line = "book 09 1-samuel 001:000 the birth of samuel"
    parse line
  end
end

def print_bible
  file.open('kjv.txt').each_line do |line|
    res = parse line
    unless res.nil?
      if res[:versenum] == 1
        print res[:bookname]
        print "chapter", res[:chapternum], "\n"
      end
      print res[:versenum], " : ", res[:versetext], "\n"
    end
  end
end

require 'pp'

def _bible_hash
  all = []
  ot = []
  nt = []
  testement = ot
  book = {name: nil, chapters: []}
  chapter = []

  file.open('kjv.txt').each_line do |line|
    res = parse line
    unless res.nil?
      if res[:chapternum] == 1 && res[:versenum] == 1
        book = {name: res[:bookname], chapters: []}
        all.append(book)
        if res[:bookname] == 'matthew'
          testement = nt
        end
        testement.append(book)
      end
      if res[:versenum] == 1
        chapter = []
        book[:chapters].append(chapter)
      end
      chapter.append(res[:versetext])
    end
  end
  {bible: all, ot:ot, nt:nt}
end

def bible_hash
  bible = {}
  book = []
  chapter = []
  file.open('kjv.txt').each_line do |line|
    res = parse line
    unless res.nil?
      if res[:bookname] =~ /^\d+/
        num,name = res[:bookname].split('-')
        res[:bookname] = name + num
      end
      if res[:bookname] == "song-of-solomon"
        res[:bookname] = "songofsolomon"
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


class testbiblehash < test::unit::testcase
  def test_bible_hash
    bible = bible_hash
    assert_equal "in the beginning god created the heaven and the earth.", bible[:genesis][1][1]
    assert_equal "for god so loved the world, that he gave his only begotten son, that whosoever believeth in him should not perish, but have everlasting life.", bible[:john][3][16]
    assert_equal "take us the foxes, the little foxes, that spoil the vines: for our vines have tender grapes.", bible[:songofsolomon][2][15]
    assert_equal "if we confess our sins, he is faithful and just to forgive us our sins, and to cleanse us from all unrighteousness.", bible[:john1][1][9]
  end
end
