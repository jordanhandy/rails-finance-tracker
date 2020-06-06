class FriendshipsController < ApplicationController
    def my_friends
      @followed_friends = current_user.friends
    end
    def create
        friend = User.find(params[:friend])
        current_user.friendships.build(friend_id)
        if current_user.save
            flash[:notice] = "Following friend"
        else
            flash[:alert] = "There was something wrong with the tracking request"
        end
        redirect_to my_firends_path
    end
    def destroy
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy
        flash[:notice] = "Stopped following"
        redirect_to my_friends_path
    end
    def search
        # if stock found, render price,
        # if stock not found, alert user
        if params[:friend].present?
        # in stock.rb file
        # @friend variable for view
        # the search method can be found in the User controller
            @friends = User.search(params[:friend])
            @friends = current_user.except_current_user(@friends)
            if @friends
                respond_to do |format|
                    format.js { render partial: 'friendships/result' }
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Couldn't find user"
                    format.js { render partial: 'friendships/result' }
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a friend name or email to search a symbol to search"
                format.js { render partial: 'friendships/result' }
            end
        end
    end
  end
  