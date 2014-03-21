class Patron

  attr_reader :name, :id

  def self.all
    results = DB.exec("SELECT * FROM patrons;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << Patron.new({:name => name, :id => id})
    end
    lists
  end

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patron)
    self.name == another_patron.name
  end

end
