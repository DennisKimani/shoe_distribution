class Brand < ActiveRecord::Base
  validates(:name, :description, :presence => true)
  has_many :stores
end
