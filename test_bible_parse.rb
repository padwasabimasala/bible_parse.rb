$: << '.'
require 'bible_parse'
require "test/unit"

require 'pp'

class TestBibleParse < Test::Unit::TestCase
  def test_bible_hash
    bible = bible_hash
    assert_equal "In the beginning God created the heaven and the earth.", bible[:Genesis][1][1]
    assert_equal "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.", bible[:John][3][16]
    assert_equal "Take us the foxes, the little foxes, that spoil the vines: for our vines have tender grapes.", bible[:SongOfSolomon][2][15]
    assert_equal "If we confess our sins, he is faithful and just to forgive us our sins, and to cleanse us from all unrighteousness.", bible[:John1][1][9]
  end

  def test_booknum
    assert_equal 1, _parsed[:booknum]
  end

  def test_bookname
    assert_equal "Genesis", _parsed[:bookname]
  end

  def test_chapternum
    assert_equal 1, _parsed[:chapternum]
  end

  def test_versenum
    assert_equal 1, _parsed[:versenum]
  end

  def test_versetext
    assert_equal "In the beginning God created the heaven and the earth.", _parsed[:versetext]
    assert_equal nil, _parsed[:chaptertitle]
  end

  def test_bookname_with_number
    assert_equal "1-Samuel", _parsed2[:bookname]
  end

  def test_versenum_of_chapter_title
    assert_equal 0, _parsed2[:versenum]
  end

  def test_chaptertitle
    assert_equal nil, _parsed2[:versetext]
    assert_equal "The Birth Of Samuel", _parsed2[:chaptertitle]
  end

  def _parsed
    line = "Book 01 Genesis 001:001 In the beginning God created the heaven and the earth."
    parse line
  end

  def _parsed2
    line = "Book 09 1-Samuel 001:000 The Birth Of Samuel"
    parse line
  end
end
