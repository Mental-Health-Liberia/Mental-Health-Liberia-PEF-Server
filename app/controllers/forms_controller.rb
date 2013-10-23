class FormsController < ApplicationController
  def index
    @forms = MongoConfig.db['forms'].find.to_a

    respond_to do |format|
      format.json { render json: @forms }
      format.xml { render xml: @forms }
    end
  end

  def create
    id = MongoConfig.db['forms'].insert(params)

    if id
      redirect_to id
    end
  end

  def show
    @form = MongoConfig.db['forms'].find("_id" => BSON::ObjectId(params[:id])).to_a

    respond_to do |format|
      format.json { render json: @form }
      format.xml { render xml: @form }
    end
  end
end
