class Todo < ActiveRecord::Base
  attr_accessible :title, :description, :status

  validates :title, presence: true, length: { minimum: 3 }

  scope :all_todos, -> { where(deleted_at: nil) }
  scope :only_deleted, -> { where("deleted_at is NOT NULL") }

  def complete? 
  	status
  end
end
