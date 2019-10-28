require 'set'

class Bible
  class Book
    attr_reader :name
    def initialize(name)
      @name = name
      @chapters = Hash.new([])
    end
  end

  def initialize
    @books = Set[]
    text.each do |line|
      book, chapnum = parse_line line
      @books.add(Book.new(book))
      @books.add(Book.new(book))
    end
  end

  def books
    @books.to_a
  end

  def parse
  end

  def parse_line(line)
    # Book 01 Genesis 001:001 In the beginning God created the heaven and the earth.
    # Book 01 Genesis 001:002 And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters.
    # Book 01 Genesis 001:003 And God said, Let there be light: and there was light.
    m = line.match /Book \d{2} (?<book>\d?-?\w+)(?<chapnum>\d+):.*/
    return [m['book'], m['chapnum']]
  end

  def text
    File.open('kjv.txt')
  end

end

bible = Bible.new
#print bible.books
