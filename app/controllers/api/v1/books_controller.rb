class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :change_status, :destroy]

  def index
    begin
      books = Books::Repositories::BookRepository.all
      if books.any?
        render json: books.map { |book| BookSerializer.new(book).as_json }, status: :ok
      else
        render json: { message: 'No books available' }, status: :no_content
      end
    rescue => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
  

  def show
    render json: BookSerializer.new(@book).as_json, status: :ok
  end

  def create
    begin
      book = Books::Services::CreateBook.new(book_params).call
      render json: BookSerializer.new(book).as_json, status: :created
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def update
    begin
      Books::Services::UpdateBook.new(@book, book_params).call
      render json: BookSerializer.new(@book).as_json, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: e.message }, status: :bad_request
    end
  end
  

  def change_status
    begin
      Books::Services::ChangeBookStatus.new(@book, params[:status]).call
      render json: { message: "Book status updated successfully" }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @book.destroy!
      render json: { message: "Book deleted successfully" }, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Books::Repositories::BookRepository.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :price, :stock, :status, :description)
  end
end
