class StocksController < ApplicationController
    def search
        # if stock found, render price,
        # if stock not found, alert user
        if params[:stock].present?
        # in stock.rb file
        # @stock variable for view
            @stock = Stock.new_lookup(params[:stock])
            if @stock
                render 'users/my_portfolio'
            else
                flash[:alert] = "Please enter a valid symbol to search"
                redirect_to my_portfolio_path
            end
        else
            flash[:alert] = "Please enter a symbol to search"
            redirect_to my_portfolio_path
        end
    end
end