class UsersController < ApplicationController
  before_filter :authenticate_user!

  before_filter :ensure_manage_users_access

  def index
  end
end
