class ConfigurationsController < ApplicationController
  include ConfigurationsHelper

  layout 'jsoneditor'

  def index
    @active_configuration = FormConfiguration.desc(:created_at).first

    if @active_configuration.nil?
      @active_configuration = FormConfiguration.new()
    end

    respond_to do |format|
      format.html
      format.json { render json: @active_configuration.body }
      format.xml { render xml: @active_configuration.body }
    end
  end

  def create
    @active_configuration = FormConfiguration.new(user_params[:form_configuration])

    unless @active_configuration.save
      error_message = @active_configuration.errors.full_messages.join("\n")
    end

    respond_to do |format|
      format.html { redirect_to({ action: "index" }, alert: error_message) }
      format.json { render json: @configuration }
      format.xml { render xml: @configuration }
    end
  end

  def show
    @configuration = FormConfiguration.find(user_params[:id].to_s)

    respond_to do |format|
      format.html { redirect_to({ action: "index" }) }
      format.json { render json: @configuration }
      format.xml { render xml: @configuration }
    end
  end

  def destroy
    @configuration = FormConfiguration.find(user_params[:id].to_s)

    unless @configuration.destroy
      error_message = @active_configuration.errors.full_messages.join("\n")
    end

    respond_to do |format|
      format.html { redirect_to({ action: "index" }, alert: error_message) }
      format.json { render json: @configuration }
      format.xml { render xml: @configuration }
    end
  end
end
