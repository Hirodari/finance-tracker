class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    return "#{first_name.capitalize} #{last_name.capitalize}" if first_name || last_name
    "Anonymous"
  end

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.checkdb(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
  def self.search(params)
    params.strip!
    to_send_back = (first_name_matches(params) + last_name_matches(params) +
    email_matches(params)).uniq
    return nil unless to_send_back
    to_send_back
  end
  def self.first_name_matches(params)
    matches("first_name", params)
  end
  def self.last_name_matches(params)
    matches("last_name", params)
  end
  def self.email_matches(params)
    matches("email", params)
  end
  def self.matches(field_name, params)
    where("#{field_name} like ?", "%#{params}%")
  end
  def except_current_user(user)
    user.reject { |usr| usr.id == self.id }
  end
  def not_friend_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end
end
