class Post < ActiveRecord::Base
	
  attr_accessible :category, :description, :location, :posted, :price, :title, :url

  validates :title,  presence: true
  # validates :price,  presence: true
  validates :url,  presence: true, uniqueness: true

end
