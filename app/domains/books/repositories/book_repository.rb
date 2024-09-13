module Books
  module Repositories
    class BookRepository
      
      def self.all
        Book.all
      end
      
      def self.create(attributes)
        ::Book.create!(attributes)
      end

      def self.find(id)
        ::Book.find(id)
      rescue ActiveRecord::RecordNotFound
        raise StandardError, "Book not found"
      end

      def self.update(book, params)
        book.update!(params)
      end

      def self.delete(book)
        book.destroy!
      end
    end
  end
end