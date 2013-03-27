require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
  end

  test "When we destroy a todo we should see one less in the model" do
    destroy_me = todos(:three)
    n_todos_before_destroy = Todo.count

    Todo.destroy destroy_me

    assert (Todo.count == n_todos_before_destroy-1), "Did not destroy a todo successfully"
  end

end
