require 'rspec'
require 'pg'
require 'author'
require 'book'
require 'checkout'
require 'copy'
require 'patron'
require 'book_authors'

DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM books_authors *;")
    DB.exec("DELETE FROM checkout *;")
    DB.exec("DELETE FROM copy *;")
    DB.exec("DELETE FROM patrons *;")
  end
end
