require './lib/author'
require './lib/book'
require './lib/checkout'
require './lib/copy'
require './lib/patron'
require './lib/book_authors'
require 'pg'

DB = PG.connect({:dbname => "library"})

def welcome

  puts "\nWelcome to the Epicodus library
  Enter 'L' for librarian menu
  Enter 'P' for patron menu"

  case gets.chomp.upcase
  when 'L'
    librarian_menu
  when 'P'
    patron_menu
  end
end

def librarian_menu
  puts "\nHello librarian! What would you like to do?
  Enter 'A' to add book
  Enter 'LB' to list books
  Enter 'LA' to list authors
  Enter 'S' to search for a book
  Enter 'X' to exit"

  case gets.chomp.upcase

  when 'LA'
    list_authors
  when 'A'
    add_book
  when 'LB'
    list_book
    librarian_menu
  when 'S'
    search_book
  when 'X'
    welcome
  else
    puts 'Invalid entry'
  end
end

def add_book
  puts "Please enter the title of the book you would like to add"
  new_book = Book.new({:name => gets.chomp})
  new_book.save
  book_copy = Copy.new({:title => new_book.name, :book_id => new_book.id, :copies => rand(1..5)})
  book_copy.save
  add_author(new_book)
end

def add_author(new_book)
  puts "Please enter the author of the book you would like to add"
  auth_name = gets.chomp
    if Author.all.find_all { |author| author.name == auth_name } != []
      found = Author.all.find_all { |author| author.name == auth_name }
      Books_Authors.new({:author_id => found.first.id, :book_id => new_book.id}).save
      additional_author(new_book)
    else
      new_author = Author.new({:name => auth_name})
      new_author.save
      Books_Authors.new({:author_id => new_author.id, :book_id => new_book.id}).save
      additional_author(new_book)
    end
end

def additional_author(new_book)
  puts "Is there another author of the book you would like to add Y/N?"
    case gets.chomp.upcase
    when "Y"
      add_author(new_book)
    when "N"
      librarian_menu
    else
      puts "Invalid input"
      add_author(new_book)
    end
end


def list_authors
  puts "Here are all of the authors"
  Author.all.each do |author|
    puts "#{author.id}) #{author.name}"
  end
  librarian_menu
end

def list_book
  puts "Here are all of the books"
  Book.all.each do |book|
    puts "#{book.id}) #{book.name}"
  end
end

def search_book
  puts "Search for book
  Press 'A' to search by author
  Press 'T' to search by title."
  case gets.chomp.upcase

  when 'A'
    puts 'Please enter the name of the author you would like to search for:'
    results = Books_Authors.search_author(gets.chomp)
    puts "Here is a list of possible matches:"
    results.each do |result|
      puts "#{result['id']}) #{result['name']}"
    end
    books = []
    puts "Enter the ID of the author to see their books"
    results = DB.exec("SELECT book_id FROM books_authors WHERE author_id = #{gets.chomp};")
    results.each do |result|
      books << result['book_id']
    end
    puts "\nHere are the books written by that author:\n"
    Book.all.each_with_index do |one, index|
      books.each do |book|
        if one.id == book.to_i
          puts "#{one.id}) #{one.name}"
        end
      end
    end
    librarian_menu
  when 'T'
    search_title
  end
end

def search_title
  puts 'Please enter the title you would like to search for:'
    results = Books_Authors.search_title(gets.chomp)
    puts "Here is a list of possible matches:"
    results.each do |result|
      puts "#{result['id']}) #{result['name']}"
    end
    authors = []
    puts "Enter the ID of the title to see their books"
    results = DB.exec("SELECT author_id FROM books_authors WHERE book_id = #{gets.chomp};")
    results.each do |result|
      authors << result['author_id']
    end
    puts "\nHere is the author(s) of that title:\n"
    Author.all.each_with_index do |one, index|
      authors.each do |author|
        if one.id == author.to_i
          puts "#{one.id}) #{one.name}"
        end
      end
      librarian_menu
  end
end

def patron_menu
  puts "\nHello patron! What would you like to do?
  Enter 'C' to checkout book
  Enter 'LB' to list books
  Enter 'LA' to list authors
  Enter 'S' to search for a book
  Enter 'X' to exit"

  case gets.chomp.upcase

  when 'LA'
    list_authors
  when 'C'
    new_patron
  when 'LB'
    list_book
  when 'S'
    search_book
  when 'X'
    welcome
  else
    puts 'Invalid entry'
  end
end

# def member_check

#   puts "Are you a current member? Y/N"

#   case gets.chomp.upcase
#   when 'Y'
#     Patron.all.each do |patron|
#       puts "#{patron.id}) #{patron.name}"
#     end
#     puts "Please enter your id"
#     checkout_book
#   when 'N'
#     new_patron
#   end
# end

def new_patron
  puts "Please enter your name"

  member_name = gets.chomp
  new_patron = Patron.new({:name => member_name})
  new_patron.save
  puts "Weclome to the libary #{member_name}!"
  checkout_book(new_patron)
end

def checkout_book(new_patron)
  puts new_patron.name
  puts 'Enter the ID of the book you would like to checkout.'
  list_book
  found = []
  book_number = gets.chomp.to_i
  results = DB.exec("SELECT * FROM copy WHERE book_id = #{book_number};")
  results.each do |result|
    if result['book_id'].to_i == book_number.to_i
      found << result['book_id'].to_i
    end
  end
  puts new_patron.id
  puts found.first
  new_checkout = Checkout.new(:patron_id => new_patron.id, :copy_id => found.first)
  puts 'Thank you for using the Epicodus library, your book is due #{Time.now +604800}'
  puts new_checkout

end

welcome


