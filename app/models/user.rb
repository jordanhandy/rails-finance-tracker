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

### Search methods for finding users  ###

# Strip all whitespace
# return results from other methods, or nil if nothing returned back
# returns unique values of results from all 3 methods

def self.search(param)
  param.strip!
  to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
  return nil unless to_send_back
  to_send_back
end

# Search for first_name, last_name, and email fields
# given params
def self.first_name_matches(param)
  matches('first_name',param)
end
def self.last_name_matches(param)
  matches('last_name',param)
end
def self.email_matches(param)
  matches('email',param)
end

# method to do searches on users, when trying to find users
# search for mathes on a specific field name, given a specific param
def self.matches(field_name, param)
  where("#{field_name} like ?", "%#{param}%")
end

end
