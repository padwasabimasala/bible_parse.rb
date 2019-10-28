$: << "."
require "bible"
require "test/unit"

# Of course the number of books (66) and chapters (1,189) are fairly easy to count. 31,102 verses
# Genesis	50	1533

class TestBible < Test::Unit::TestCase
  def test_init
    assert_nothing_raised do
      Bible.new()
    end
  end

  def test_books
    bible = Bible.new()
    assert_equal(66, Bible.new().books.length)
  end

  def test_books_subindex
    bible = Bible.new()
    assert_equal("Genesis", Bible.new().books[0].name)
    assert_equal(50, Bible.new().books[0].verses.length)
  end
end

__END__
bible = Bible.new
bible.books -> []
bible.books.genesis -> ['']
bible.books.genesis[0] -> ''
bible.books.genesis.chapters[0] -> []
bible.genesis -> [[]]
bible.find("genesis 1:1")
bible.find("genesis 1:1")
bible.find("genesis 1:1")
bible.books.chapters.first.each do |verse|
  print verse
end
gen = bible.books.genesis
gen.chapters.each do |verse|
  print verse
end
