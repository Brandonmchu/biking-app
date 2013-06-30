class Bike < ActiveRecord::Base
  attr_accessible :description, :price, :title, :url, :posted

  validates :title,  presence: true
  # validates :price,  presence: true
  validates :url,  presence: true, uniqueness: true

end
