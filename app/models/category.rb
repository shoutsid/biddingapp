class Category < ActiveRecord::Base
  has_many :items
  validates :name, presence: true

  acts_as_url :name

  def to_param
    url 
  end
end
