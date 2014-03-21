class Copy

  attr_reader :title, :id, :copies, :book_id

  def self.all
    results = DB.exec("SELECT * FROM copy;")
    lists = []
    results.each do |result|
      title = result['title']
      copies = result['copies'].to_i
      book_id = result['book_id'].to_i
      id = result['id'].to_i
      lists << Copy.new({:title => title, :id => id, :copies => copies, :book_id => book_id
        })
    end
    lists
  end

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
    @copies = attributes[:copies]
    @book_id = attributes[:book_id]
  end

  def save
    results = DB.exec("INSERT INTO copy (title, copies, book_id) VALUES ('#{@title}', #{@copies}, #{@book_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_copy)
    self.title == another_copy.title && self.id == another_copy.id && self.book_id == another_copy.book_id && self.copies == another_copy.copies
  end

end
