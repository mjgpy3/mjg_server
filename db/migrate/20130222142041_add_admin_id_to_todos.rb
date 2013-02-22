class AddAdminIdToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :admin_id, :integer
  end
end
