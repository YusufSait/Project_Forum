class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]


  include TopicsHelper
  before_filter :require_login, only: [:show, :edit, :update, :destroy]
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.find(1)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @username= User.find(@topic.user_id).username
    @sub_topic = Topic.new
    @comment = Comment.new
    @is_owner=owner?
  end

  def owner?
    if current_user.id==@topic.user_id
      return true
    end
    return false
  end


  # GET /topics/1/edit
  def edit
  end

    def new
      @topic=Topic.new
    end

  # POST /topics
  # POST /topics.json
  def create
    @sub_topic = Topic.new(topic_params)
    @sub_topic.user_id = current_user.id
    @sub_topic.topic_id = params[:topic_id]
    respond_to do |format|
      if @sub_topic.save
        format.html { redirect_to @sub_topic, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sub_topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @sub_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit( :topic_id, :title, :description)
    end
end
