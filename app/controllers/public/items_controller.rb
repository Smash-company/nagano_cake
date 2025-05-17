class Public::ItemsController < ApplicationController

  def index
    # ページネーションの対象を販売ステータスのtrueに絞る、ページネーション設定
    @items = Item.where(is_active: true).page(params[:page]).per(8)
    @active_items_count = Item.where(is_active: true).count
    @genres = Genre.all
  end


  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new  #修正しました
    @genres = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :opinion, :image, :price)
  end

end
