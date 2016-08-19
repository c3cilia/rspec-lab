require 'spec_helper'
require 'book'

describe Book do
	before :each do
		@book = Book.new "Title", "Author", :category
	end

	describe "#new" do
		it "returns a book object" do
			expect(@book).to be_an_instance_of(Book)
		end

		it "raises an ArgumentError when given fewer than 3 parameters" do
			book = lambda {Book.new "Title", "Author"}
			expect(&book).to raise_error ArgumentError
		end
	end 

	describe "#title" do
		it "returns the correct title" do
			expect(@book.title).to eq("Title")
		end 
	end 

	describe "#author" do
		it "returns the correct author" do
			expect(@book.author).to eq("Author")
		end 
	end 

	describe "#category" do
		it "returns the correct category" do
			expect(@book.category).to eq(:category)
		end 
	end 

end