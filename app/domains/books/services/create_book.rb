module Books
  module Services
    class CreateBook
      def initialize(params)
        @params = params
      end

      def call
        Books::Repositories::BookRepository.create(@params)
      end
    end
  end
end