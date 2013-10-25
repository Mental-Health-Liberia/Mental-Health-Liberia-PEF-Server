class FormsController < ApplicationController
  IGNORED_PARAM_KEYS = [:format, :controller, :action]

  def index
    @forms = MongoConfig.db['forms'].find.to_a

    respond_to do |format|
      format.json { render json: @forms }
      format.xml { render xml: @forms }
    end
  end

  def create
    id = MongoConfig.db['forms'].insert(@params.except(*IGNORED_PARAM_KEYS))
    
    @params[:id] = id.to_s
    self.show
  end

  def show
    @form = MongoConfig.db['forms'].find("_id" => BSON::ObjectId(@params[:id])).to_a

    respond_to do |format|
      format.json { render json: @form }
      format.xml { render xml: @form }
    end
  end
end
