class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  
  # GET /stories
  # GET /stories.json
  def index
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @stories = Story.all.order( 'stories.updated_at DESC' )
    else
      redirect_to root_url
    end
  end
  
  # GET /stories/admin
  # GET /stories/admin.json
  def admin
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @stories = Story.all.order(:story)
      @storycount = Story.count
    else
      redirect_to root_url
    end
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @story = Story.new
      @categories = Category.all.order( 'category ASC' )
    else
      redirect_to root_url
    end
  end

  # GET /stories/1/edit
  def edit
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @categories = Category.all.order( 'category ASC' )
    else
      redirect_to root_url
    end
  end

  # POST /stories
  # POST /stories.json
  def create
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @story = Story.new(story_params)
      respond_to do |format|
        if @story.save(story_params)
          format.html { redirect_to :action => 'admin', notice: 'Story was successfully created.' }
          format.json { render :show, status: :created, location: @story }
        else
          format.html { render :new }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      respond_to do |format|
        if @story.update(story_params)
          format.html { redirect_to :action => 'admin', notice: 'Story was successfully updated.' }
          format.json { render :show, status: :ok, location: @story }
        else
          format.html { render :edit }
          format.json { render json: @story.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    if current_user.nil? 
      redirect_to root_url
    elsif current_user.role == 'editor'
      @story.destroy
      respond_to do |format|
        format.html { redirect_to :action => 'admin', notice: 'Story was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:category_id, :description, :last_active, :status, :story, :urgency, :keywords, :parent_id)
    end
end