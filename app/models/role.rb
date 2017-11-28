class Role < ApplicationRecord
  has_many :users, through: :assignments
  has_many :assignments

  validates :name, presence:true, uniqueness:true
end
