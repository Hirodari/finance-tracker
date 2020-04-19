class FriendshipsController < ApplicationController
  def create
    #byebug
    friend = User.find(params[:user])
    if friend.present?
      current_user.friends << friend
      flash[:notice] = "#{friend.first_name.capitalize} is followed by
      #{current_user.first_name.capitalize}"
      redirect_to my_friends_path
    else
      flash[:alert] = "Something went wrong"
      redirect_to my_friends_path
    end
    #usr.friends << usr_2
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice]= "stopped following #{friendship.friend.first_name.capitalize}"
    redirect_to my_friends_path

  end
end
