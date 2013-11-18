module ConfigurationsHelper
  def user_params
    @params.except!(*[:format, :controller, :action])
  end
end
