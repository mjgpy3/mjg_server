class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :description
      t.string :color
      t.boolean :completed
      t.integer :user_id

      t.timestamps
    end
  end
end
