require 'spec_helper'

describe 'Books_authors' do
  it 'creates an new instance of Books_authors' do
    book_new = Books_Authors.new( {:author_id => 1, :book_id => 1})
    book_new.should be_an_instance_of Books_Authors
  end
  it 'saves an instance of book' do
    book_new = Books_Authors.new( {:author_id => 1, :book_id => 1})
    book_new.save
    Books_Authors.all.should eq [book_new]
 end

  it 'is the same task if it has the same name and ID' do
    book1 = Books_Authors.new({:author_id => 1, :book_id => 1})
    book2 = Books_Authors.new({:author_id => 1, :book_id => 1})
    book1.should eq book2
  end
end
