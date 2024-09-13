module Books
  module Services
    class CreateBook
      def initialize(params)
        @params = params
      end

      def call
        # Instantiate a new Book entity
        book_entity = Books::Entities::Book.new(@params)

        # Validate the book entity
        unless book_entity.valid?
          raise StandardError, "Invalid book data"
        end

        # Persist the entity using the repository
        book = Books::Repositories::BookRepository.create(book_entity.to_h)
        book
      end
    end
  end
end
