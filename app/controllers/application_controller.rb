class ApplicationController < ActionController::Base
    # from devise.  Before anything is done, authenticate the user
    before_action :authenticate_user!
end
