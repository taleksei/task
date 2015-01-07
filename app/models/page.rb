class Page < ActiveRecord::Base
  attr_accessible :content, :title, :name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, length: { maximum: 50 }
  validates :password, length: { minimum: 1 }
end
