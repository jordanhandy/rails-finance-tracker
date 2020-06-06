class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# if the stock is already tracked
# create a stock variable, where we check the database for an existing ticker symbol
# if one does not exist, we return false
# if one does exist, we return true / false where the stock exists as a tracked stock in the user table
def stock_already_tracked?(ticker_symbol)
  stock = Stock.check_db(ticker_symbol)
  return false unless stock
  stocks.where(id: stock.id).exists?
end

# we check if the current number of stocks associated with the user is less than 10
def under_stock_limit?
  stocks.count < 10
end

# if they are under the stock limit, and the stock is not being tracked,
# let them track the stock
def can_track_stock?(ticker_symbol)
  under_stock_limit? && !stock_already_tracked?(ticker_symbol)
end

def full_name
  return "#{first_name} #{last_name}" if first_name || last_name
  "Anonymous"
end
end
