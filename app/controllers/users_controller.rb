class UsersController < ApplicationController
	before_action :authenticate_user! 
	def my_portfolio
		@user = current_user
		@user_stocks = current_user.stocks	
	end

	def my_friends
		@friendships = current_user.friends
	end

	def search
		@users = User.search(params[:search_param])
		render json: @users
	end
	
	def search
	  if params[:search_param].blank?
	     flash.now[:danger] = "You have entered an empty search"
	   else
	      @users = User.search(params[:search_param])
	      @users = current_user.except_current_user(@users)
	      flash.now[:danger] = "No users match this search" if @users.blank?
	  end
		respond_to do |format|
			format.js { render partial: 'friends/result' }
		end
	end

	def add_friend
		@friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: @friend.id)
		
		if current_user.save
			flash[:success] = "Freind added"
		else
			flash[:danger] = "Friend request failed"
		end
		redirect_to my_friends_path
	end

	def show
		@user = User.find(params[:id])
		@user_stocks = @user.stocks
	end

	private

end