require 'spec_helper'

describe 'Copy' do
  it 'creates an new instance of book' do
    book_new = Copy.new( {:title => 'Casino Royale'})
    book_new.should be_an_instance_of Copy
  end
  it 'saves an instance of book' do
    book_new = Copy.new( {:title => 'Casino Royale', :id => 1, :copies => 5, :book_id => 2})
    book_new.save
    Copy.all.should eq [book_new]
 end

  it 'is the same task if it has the same name and ID' do
    book1 = Copy.new({:title => 'Casino Royale'})
    book2 = Copy.new({:title => 'Casino Royale'})
    book1.should eq book2
  end
end
