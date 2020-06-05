class StocksController < ApplicationController
    def search
        # if stock found, render price,
        # if stock not found, alert user
        if params[:stock].present?
        # in stock.rb file
        # @stock variable for view
            @stock = Stock.new_lookup(params[:stock])
            if @stock
                respond_to do |format|
                    format.js { render 'users/result' }
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Please enter a valid symbol to search"
                    format.js { render 'users/result' }
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a symbol to search"
                format.js { render 'users/result' }
            end
        end
    end
end