class Book

  attr_reader :name, :id

  def self.all
    results = DB.exec("SELECT * FROM books;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << Book.new({:name => name, :id => id})
    end
    lists
  end

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_book)
    self.name == another_book.name
  end

end
