class SessionsController < Devise::SessionsController
  skip_before_filter :require_no_authentication
  before_filter :check_concurrent_session

  def check_concurrent_session
    if is_already_logged_in?
      sign_out(current_user)
    end
  end

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
  end
 
  def failure
    return render :json => {:success => false, :errors => ["The username or password you entered is incorrect."]}
  end

  protected 

  def is_already_logged_in?
    current_user
  end
end