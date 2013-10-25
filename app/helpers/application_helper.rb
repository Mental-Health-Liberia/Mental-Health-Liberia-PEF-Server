module ApplicationHelper
  def assign_params
    @params ||= params
  end
end
