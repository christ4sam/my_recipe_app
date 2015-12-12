class Recipe < ActiveRecord::Base
  belongs_to :chef
  has_many  :likes
  has_many :recipe_styles
  has_many :styles, through: :recipe_styles
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
 
  validates :chef_id, presence: true
  validates  :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :summary, presence: true, length: { minimum: 10, maximum: 150 }
  validates :description, presence: true, length: { minimum: 20, maximum: 500 }
  
  mount_uploader :picture, PictureUploader
  validate :picture_size   #ensures the image size allowed is less than 5MB
  default_scope -> { order(updated_at: :desc) }#diplays the most recent recipe created
  
  #this is the method to count the total thumbs up votes  and total thumbs down votes each recipe has
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  
  def thumbs_down_total
    self.likes.where(like: false).size
  end
  
  
  # this server side validation ensures user can not upload image that is bigger than 5megabytes in size
  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
      
end