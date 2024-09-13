module Books
  module Services
    class UpdateBook
      def initialize(book, params)
        @book = book
        @params = params
      end

      def call
        #book_entity = Books::Entities::Book.new(@book.attributes.merge(@params))
        book_entity = Books::Entities::Book.new(
          @book.slice(
            :title, 
            :author, 
            :price, 
            :stock, 
            :status, 
            :description
          ).merge(@params)
        )

        # Validate the updated book entity
        unless book_entity.valid?
          raise StandardError, "Invalid book data"
        end

        # Persist changes to the book
        @book.update!(book_entity.to_h)
        @book
      end
    end
  end
end
