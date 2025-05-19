class Public::GenresController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = Item.where(genre_id: @genre.id)
    @item_count = @items.count
    @genre_items = @items.page(params[:page]).per(8)
  end
end