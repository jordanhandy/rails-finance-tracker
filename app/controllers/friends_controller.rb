class FriendsController < ApplicationController
    def my_friends
      @followed_friends = current_user.friends
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
                    format.js { render partial: 'friends/result' }
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Couldn't find user"
                    format.js { render partial: 'friends/result' }
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a friend name or email to search a symbol to search"
                format.js { render partial: 'friends/result' }
            end
        end
    end
  end
  