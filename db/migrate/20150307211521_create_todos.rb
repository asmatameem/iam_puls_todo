class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
    	t.string :title
    	t.string :description
    	t.boolean :status
    	t.datetime :deleted_at
      t.timestamps
    end
  end
end
