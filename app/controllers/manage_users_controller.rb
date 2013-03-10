class ManageUsersController < ApplicationController
  before_filter :authenticate_user!, :authenticate_admin

  def list
    @users = User.all
  end

  def delete_multiple
    params.keys.each do |key|
      User.destroy(params[key].to_i) if key.include? "selected_user" and params[key].to_i != current_user.id
    end
    redirect_to manage_users_list_path
  end

private

  def authenticate_admin
    if not current_user.is_admin?
      redirect_to todos_path
    end
  end
end
