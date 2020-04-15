class UserStocksController < ApplicationController

  def create
    stock = Stock.checkdb(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
      #flash[:notice] = "#{stock.name} saved to the DB"
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "#{stock.name} was successfully added to your Portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    #byebug
    stock = Stock.find(params[:id])
    userstock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    userstock.destroy
    flash[:alert] = "#{stock.name} was removed from Portfolio"
    redirect_to my_portfolio_path
  end

end
