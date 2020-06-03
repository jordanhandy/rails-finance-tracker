class StocksController < ApplicationController
    def search
        # in stock.rb file
        # @stock variable for view
        @stock = Stock.new_lookup(params[:stock])
        render 'users/my_portfolio'
    end
end