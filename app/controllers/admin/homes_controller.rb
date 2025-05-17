class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]
  
  def top
    @orders = Order.all
  end
end
