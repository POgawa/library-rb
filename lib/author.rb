class Author

  attr_reader :name, :id

  def self.all
    results = DB.exec("SELECT * FROM authors;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << Author.new({:name => name, :id => id})
    end
    lists
  end

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_author)
    self.name == another_author.name
  end



end


# puts "Please enter the author of the book you would like to add"
#   new_author = Author.new({:name => gets.chomp})
#   puts "Is there another author of the book you would like to add Y/N?"
#   new_author = Author.new({:name => gets.chomp})
