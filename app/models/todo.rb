class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :project_id, :title, :presence => true
end
