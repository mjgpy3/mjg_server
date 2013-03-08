class TexTrierController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @tex_code = params[:tex_code]

    # TODO: Handle tex code in corrisponding view

    monkey
  end
end
