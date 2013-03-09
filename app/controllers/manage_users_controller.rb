class ManageUsersController < ApplicationController
  before_filter :authenticate_user!, :authenticate_admin

  def list
  end

private

  def authenticate_admin
    if not current_user.is_admin?
      redirect_to todos_path
    end
  end
end
