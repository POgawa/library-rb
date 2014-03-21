require 'spec_helper'

describe 'Book' do
  it 'creates an new instance of book' do
    book_new = Book.new( {:name => 'Casino Royale'})
    book_new.should be_an_instance_of Book
  end
  it 'saves an instance of book' do
    book_new = Book.new( {:name => 'Casino Royale'})
    book_new.save
    Book.all.should eq [book_new]
 end

  it 'is the same task if it has the same name and ID' do
    book1 = Book.new({:name => 'Casino Royale'})
    book2 = Book.new({:name => 'Casino Royale'})
    book1.should eq book2
  end
end
