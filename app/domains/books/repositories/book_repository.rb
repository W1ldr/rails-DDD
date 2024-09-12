module Books
  module Repositories
    class BookRepository
      def self.find(id)
        Book.find(id)
      end

      def self.all
        Book.all
      end

      def self.create(params)
        Book.create!(params)
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