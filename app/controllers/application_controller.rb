class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery

  before_filter :assign_params

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' or Rails.env.test? }
end
