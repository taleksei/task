class Page < ActiveRecord::Base
  attr_accessible :content, :title, :name
  VALID_NAME_REGEX = /\A[a-zA-Z0-9]*\z/i
  validates :name, presence: true, format: { with: VALID_NAME_REGEX }, length: { maximum: 50, minimum: 1 }
  validates :title, presence: true, length: { maximum: 50, minimum: 1 }
end
