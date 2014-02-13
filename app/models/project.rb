class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
  has_many :todos
  validates :title, :presence => true
end
