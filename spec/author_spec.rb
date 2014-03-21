require 'spec_helper'

describe 'Author' do
  it 'creates an new instance of author' do
    author_new = Author.new( {:name => 'Ian Flemming'})
    author_new.should be_an_instance_of Author
  end
  it 'saves an instance of author' do
    author_new = Author.new( {:name => 'Ian Flemming'})
    author_new.save
    Author.all.should eq [author_new]
 end

  it 'is the same task if it has the same name and ID' do
    author1 = Author.new({:name => 'Ian Flemming'})
    author2 = Author.new({:name => 'Ian Flemming'})
    author1.should eq author2
  end
end
