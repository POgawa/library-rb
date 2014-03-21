require 'spec_helper'

describe 'Patron' do
  it 'creates an new instance of patron' do
    book_new = Patron.new( {:name => 'George'})
    book_new.should be_an_instance_of Patron
  end
  it 'saves an instance of book' do
    book_new = Patron.new( {:name => 'George'})
    book_new.save
    Patron.all.should eq [book_new]
 end

  it 'is the same task if it has the same name and ID' do
    book1 = Patron.new({:name => 'George'})
    book2 = Patron.new({:name => 'George'})
    book1.should eq book2
  end
end
