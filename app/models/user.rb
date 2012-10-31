class User < ActiveRecord::Base
  attr_accessible :email, :name
  validates :name, {length: {maximum: 140} , presence: true}
  validates :email, presence: true
end
