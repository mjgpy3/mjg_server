class ManageUsersController < ApplicationController
  before_filter :authenticate_user!, :authenticate_admin

  def list
    @users = User.all
    json_objects =  []

    @users.each do |user|
      json_objects << "{\"id\": \"#{user.id}\"," + 
                      "\"email\": \"#{user.email}\","+
                      "\"admin\": \"#{(user.is_admin ? "true" : "false")}\","+
                      " \"creation_date\": \"#{user.created_at}\","+
                      "\"tr_elem\": \"\"}"
    end

    @users_json = "{\"users\": [#{ json_objects.join ',' }]}"
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
