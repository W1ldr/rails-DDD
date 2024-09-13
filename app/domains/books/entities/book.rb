module Books
  module Entities
    class Book
      attr_accessor :title, :author, :price, :stock, :status, :description

      def initialize(attrs = {})
        @title = attrs[:title]
        @author = attrs[:author]
        @price = attrs[:price]
        @stock = attrs[:stock]
        @status = attrs[:status]
        @description = attrs[:description]
      end

      # Example validation: price must be greater than 0
      def valid?
        return false if @price.nil? || @price.to_f <= 0
        return false if @title.nil? || @title.empty?
        return false if @status.nil? || !["active", "inactive"].include?(@status)

        true
      end

      def change_status(new_status)
        if ["active", "inactive"].include?(new_status)
          @status = new_status
        else
          raise StandardError, "Invalid status"
        end
      end

      def to_h
        {
          title: @title,
          author: @author,
          price: @price,
          stock: @stock,
          status: @status,
          description: @description
        }
      end
    end
  end
end
