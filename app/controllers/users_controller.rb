class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    #byebug
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    #byebug
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      respond_to do |format|
        format.js {render partial: 'users/search_results'}
      end
    end
  end

end
