require 'spec_helper'

describe 'Checkout' do
  it 'creates an new instance of patron' do
    book_new = Checkout.new( {:copy_id => 1})
    book_new.should be_an_instance_of Checkout
  end
  it 'saves an instance of book' do
    book_new = Checkout.new( {:copy_id => '1', :patron_id => '2', :id => '3', :due_date => Time.now})
    book_new.save
    Checkout.all.should eq [book_new]
 end

  it 'is the same task if it has the same name and ID' do
    book1 = Checkout.new({:copy_id => 1})
    book2 = Checkout.new({:copy_id => 1})
    book1.should eq book2
  end
end
