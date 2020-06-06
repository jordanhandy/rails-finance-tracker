class FriendsController < ApplicationController
    def my_friends
      @followed_friends = current_user.friends
    end
  end
  