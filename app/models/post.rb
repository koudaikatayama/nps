class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :genre
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :spot_image
  
  validates :name, presence: true
  validates :explanation, length: { minimum: 1, maximum: 100 }
    
  def get_spot_image
    (spot_image.attached?) ? spot_image : 'no_spot_image.jpg'
  end
  
  def liked_by?(user)
   likes.exists?(user_id: user.id)
  end
  
end
