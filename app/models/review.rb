class Review < ApplicationRecord

  belongs_to :reviewable, polymorphic: true
  validates :name, :description, :title, presence:true

end
