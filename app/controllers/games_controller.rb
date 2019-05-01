class GamesController < ApplicationController
  def show
    # @book = Book.find(params[:id])
    # @review = Review.new

    @game = Game.find(params[:id])
  end
end
