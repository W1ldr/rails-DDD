class BookSerializer
  def initialize(book)
    @book = book
  end

  def as_json
    {
      id: @book.id,
      title: @book.title,
      author: @book.author,
      price: @book.price,
      stock: @book.stock,
      status: @book.status,
      description: @book.description
    }
  end
end