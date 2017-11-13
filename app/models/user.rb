class User < ApplicationRecord

  has_secure_password
  has_many :assignments
  has_many :roles, through: :assignments


  validates :username, presence: true, uniqueness:true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 8 }, allow_blank:true
end
