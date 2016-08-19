require 'yaml'

class Library
	attr_accessor :books

	def initialize lib_file = false
		@lib_file = lib_file
		@books = @lib_file ? YAML::load(File.read(@lib_file)) : []
	end 

	def get_books_in_category category
		@books.select do |book|
			book.category == category
		end
	end

	def add_new_book book
		@books = @books.push(book)
	end

	def get_book title
		@books.bsearch do |book|
			book.title == title	
		end
	end 

	def save lib_file = false
		@lib_file = lib_file || @lib_file || "libray.yml"
		File.open lib_file, "w" do |f|
			f.write YAML::dump @books
		end
	end
end 