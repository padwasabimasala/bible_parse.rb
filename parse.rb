file = 'kjv-head.txt'

def parse(line)
  res = {}
  m = line.match /Book (\d{2}) (\d?\s?\w+) (\d+):(\d+) (.*)/
  print m
  res[:booknum] = m[1].to_i
  res[:bookname] = m[2]
  res[:chapternum] = m[3].to_i
  res[:versenum] = m[4].to_i
  if res[:versenum] > 0
    res[:versetext] = m[5]
  else
    res[:chaptertitle] = m[5]
  end
  return res
end

require "test/unit"

# Of course the number of books (66) and chapters (1,189) are fairly easy to count. 31,102 verses
# Genesis	50	1533

class TestBible < Test::Unit::TestCase
  def parsed
    line = "Book 01 Genesis 001:001 In the beginning God created the heaven and the earth."
    parse line
  end

  def parsed2
    line = "Book 09 1 Samuel 001:000 The Birth of Samuel"
    parse line
  end

  def test_booknum
    assert_equal 1, parsed[:booknum]
  end

  def test_bookname
    assert_equal "Genesis", parsed[:bookname]
  end

  def test_chapternum
    assert_equal 1, parsed[:chapternum]
  end

  def test_versenum
    assert_equal 1, parsed[:versenum]
  end

  def test_versetext
    assert_equal "In the beginning God created the heaven and the earth.", parsed[:versetext]
    assert_equal nil, parsed[:chaptertitle]
  end

  def test_bookname_with_number
    assert_equal "1 Samuel", parsed2[:bookname]
  end

  def test_versenum_of_chapter_title
    assert_equal 0, parsed2[:versenum]
  end

  def test_chaptertitle
    assert_equal nil, parsed2[:versetext]
    assert_equal "The Birth of Samuel", parsed2[:chaptertitle]
  end
end
