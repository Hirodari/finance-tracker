class StocksController < ApplicationController
  def search
      #byebug
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      #render json: @stock
      if @stock
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
        #render 'users/my_portfolio'
      else
        respond_to do |format|
          flash.now[:notice] = "Please enter a valid stock symbol to search"
          format.js {render partial: 'users/result'}
        #redirect_to my_portfolio_path
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter stock symbol"
        format.js {render partial: 'users/result'}
      #redirect_to my_portfolio_path
      end
    end
    #render json: @stock
  end
end
