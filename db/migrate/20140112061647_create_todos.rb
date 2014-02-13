class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string  :title
      t.text  :descrption
      t.integer :project_id
      t.integer :user_id
      t.string  :status

      t.timestamps
    end
  end
end
