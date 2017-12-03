class FriendshipsController < ApplicationController
	before_action :authenticate_user! 
	
	def destroy
		@friendship = current_user.friendships.where(friend_id: params[:id]).first 
		@friendship.destroy
		flash[:notice] = "Friend removed"
		redirect_to my_friends_path
	end

	private

end