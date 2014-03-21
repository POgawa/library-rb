class Books_Authors

  attr_reader :book_id, :author_id

  def initialize(attributes)
    @book_id = attributes[:book_id]
    @author_id = attributes[:author_id]
  end

  def self.search_author(name)
    DB.exec("SELECT * FROM authors WHERE name LIKE '#{name}%';")
  end

  def self.search_title(name)
    DB.exec("SELECT * FROM books WHERE name LIKE '#{name}%';")
  end

  def self.all
    results = DB.exec("SELECT * FROM books_authors;")
    lists = []
    results.each do |result|
      id = result['id'].to_i
      book_id = result['book_id'].to_i
      author_id = result['author_id'].to_i
      lists << Books_Authors.new({:book_id => book_id, :author_id => author_id, :id => id})
    end
    lists
  end


  def save
    results = DB.exec("INSERT INTO books_authors (author_id, book_id) VALUES (#{@author_id}, #{@book_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_booksauthors)
    self.author_id == another_booksauthors.author_id && self.book_id == another_booksauthors.book_id
  end
end
