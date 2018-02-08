class TopicsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_moderator, only: [:edit, :update]
  before_action :authorize_admin, only: [:new, :create, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to @topic, notice: "Topic was successfully created"
    else
      flash.now[:alert] = "Topic was not created. Please try again"
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was successfully updated"
      redirect_to @topic
    else
      flash.now[:alert] = "Topic was not created. Please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was successfully deleted"
      redirect_to action: :index
    else
      flash.now[:alert] = "Error deleting topic. Please try again"
      render :show
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end

  def authorize_moderator
    unless current_user.moderator? || current_user.admin?
      flash[:alert] = "You must be an admin or moderator to do that."
      redirect_to topics_path
    end
  end


end
