require 'spec_helper'
require 'library'
require 'book'

describe "Library Object" do
	before :all do
		lib_arr = [
			Book.new("Fifity shades of black", "Jennice obrian", :erotic),
			Book.new("The wild wild west", "Juniper lee", :erotic),  
			Book.new("My pet", "Sydney Sheldon", :adventure),
			Book.new("The blood moon", "Harry cooper", :horror),
		]

		File.open "books.yml", "w" do |f|
			f.write YAML::dump lib_arr			
		end
	end

	before :each do
			@lib = Library.new "books.yml"
	end 

	describe "#new" do
		context "with no parameters" do
			it "has no books" do
				lib = Library.new
				expect(lib.books.size).to eq(0)
			end
		end

		context "with a yaml file name parameter" do
			it "has three books" do
				expect(@lib.books.size).to eql(4)
			end 
		end 
	end

	it "returns all books in a given category" do
		expect(@lib.get_books_in_category(:erotic).size).to eql(2)
	end 

	it "accepts new books" do
		@lib.add_new_book(Book.new("P5JS", "Lauren MCathy", :development))
		expect(@lib.get_book("P5JS")).to be_an_instance_of Book
	end

	it "saves the library" do
		books = @lib.books.map {|book| book.title}
		@lib.save
		lib2 = Library.new "our_new_lib.yml"
		books2 = lib2.books.map{|book| book.title}
		expect(books).to eql(books2)
	end 
end 