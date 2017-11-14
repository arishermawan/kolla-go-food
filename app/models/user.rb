class User < ApplicationRecord

  has_secure_password
  has_many :assignments
  has_many :roles, through: :assignments
  has_many :orders


  validates :username, presence: true, uniqueness:true
  validates :gopay, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank:true
end
