class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy, :change_status]

  # GET /api/v1/books
  def index
    books = Books::Repositories::BookRepository.all
    render json: books.map { |book| BookSerializer.new(book).as_json }, status: :ok
  end

  # GET /api/v1/books/:id
  def show
    render json: BookSerializer.new(@book).as_json, status: :ok
  end

  # POST /api/v1/books
  def create
    book = Books::Services::CreateBook.new(book_params).call
    render json: BookSerializer.new(book).as_json, status: :created
  end

  # PATCH/PUT /api/v1/books/:id
  def update
    Books::Services::UpdateBook.new(@book, book_params).call
    render json: BookSerializer.new(@book).as_json, status: :ok
  end

  # DELETE /api/v1/books/:id
  def destroy
    Books::Services::DeleteBook.new(@book).call
    render json: { message: 'Book deleted successfully' }, status: :ok
  end

  # PATCH /api/v1/books/:id/change_status
  def change_status
    Books::Services::ChangeBookStatus.new(@book, params[:status]).call
    render json: { message: 'Book status updated successfully' }, status: :ok
  end

  private

  def set_book
    @book = Books::Repositories::BookRepository.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :stock, :status, :description)
  end
end