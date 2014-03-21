class Checkout

  attr_reader :copy_id, :id, :patron_id, :due_date

  def self.all
    results = DB.exec("SELECT * FROM checkout;")
    lists = []
    results.each do |result|
      due_date = result['due_date']
      id = result['id'].to_i
      copy_id = result['copy_id'].to_i
      patron_id = result['patron_id'].to_i
      lists << Checkout.new({:id => id, :copy_id => copy_id, :patron_id => patron_id, :due_date => due_date})
    end
    lists
  end

  def initialize(attributes)
    @due_date = attributes[:due_date]
    @id = attributes[:id]
    @copy_id = attributes[:copy_id]
    @patron_id = attributes[:patron_id]
  end

  def save
    results = DB.exec("INSERT INTO checkout (copy_id, id, patron_id, due_date) VALUES (#{@id},#{@copy_id}, #{@patron_id}, #{Time.now + 604800}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_checkout)
    self.id == another_checkout.id
  end

end
