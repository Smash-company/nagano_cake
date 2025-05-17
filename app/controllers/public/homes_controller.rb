class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]
  def top
    @genres = Genre.all
    @items = Item.where(is_active: true).order('id DESC').limit(4) #DESCは降順（大きい順）並び変えの為ですが要確認。
  end

  def about
  end
end
