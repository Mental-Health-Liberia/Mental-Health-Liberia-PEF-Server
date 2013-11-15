class FormsController < ApplicationController
  IGNORED_PARAM_KEYS = [:format, :controller, :action]

  before_filter :authenticate_user!

  before_filter :ensure_write_api_access, only: [:create]
  before_filter :ensure_read_api_access, except: [:create]

  def index
    @params.except!(*IGNORED_PARAM_KEYS)

    if @params.length > 0
      @forms = MongoConfig.db['forms'].find(@params).to_a
    else
      @forms = MongoConfig.db['forms'].find.to_a
    end

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
    if BSON::ObjectId.legal?(@params[:id]) == false
      message = {
        "error" => "The given id was not a valid BSON ObjectId."
      }

      respond_to do |format|
        format.json { render :json => message }
        format.xml { render :xml => message }
      end
    else
      @form = MongoConfig.db['forms'].find("_id" => BSON::ObjectId(@params[:id])).to_a

      if @form.length == 0
        message = {
          "error" => "The given id was not found."
        }

        respond_to do |format|
          format.json { render :json => message }
          format.xml { render :xml => message }
        end
      else
        respond_to do |format|
          format.json { render json: @form }
          format.xml { render xml: @form }
        end
      end
    end
  end
end
