class Category < ActiveRecord::Base
  has_many :items
  validates :name, presence: true
  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_url :name

  def to_param
    url 
  end
end
