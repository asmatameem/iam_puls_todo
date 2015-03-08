class Todo < ActiveRecord::Base
  attr_accessible :title, :description, :status

  validate :title, presence: true

  scope :all_todos, -> { where(deleted_at: nil) }

  def complete? 
  	status
  end
end
