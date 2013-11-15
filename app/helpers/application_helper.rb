module ApplicationHelper
  def assign_params
    @params ||= params
  end

  def ensure_read_api_access
    redirect_to :root unless current_user.read_api?
  end

  def ensure_write_api_access
    redirect_to :root unless current_user.write_api?
  end

  def ensure_manage_users_access
    redirect_to :root unless current_user.manage_users?
  end

  def ensure_modify_configuration_access
    redirect_to :root unless current_user.modify_configuration?
  end
end
