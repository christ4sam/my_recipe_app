class Chef < ActiveRecord::Base
  has_many :recipes
  has_many :likes
  before_save {self.email = email.downcase } # this line of code ensures that before any email is save in the DB
                                             #it first converts to downcase
  validates :chefname, presence: true, length: { minimum: 3, maximum: 40 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
                             uniqueness: { case_sensitive: false },
                             format: { with: VALID_EMAIL_REGEX  }
has_secure_password  #this is for our secure password authentication for our  chefs
                              
end