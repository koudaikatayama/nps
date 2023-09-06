class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :genre
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :spot_image
  
  has_many :association_post_and_tags, dependent: :destroy
  has_many :tags, through: :association_post_and_tags
  
  validates :name, presence: true
  validates :explanation, length: { minimum: 1, maximum: 100 }, presence: true
    
  def get_spot_image
    (spot_image.attached?) ? spot_image : 'no_spot_image.jpg'
  end
  
  def liked_by?(user)
   likes.exists?(user_id: user.id)
  end
  
  def self.search(keyword)
    where("name LIKE ?", "%#{keyword}%")
  end
  
end
