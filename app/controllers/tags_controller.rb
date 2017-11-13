class TagsController < ApplicationController

  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |f|
      if @tag.save
        f.html { redirect_to @tag, notice: 'Tag has succesfully saved' }
        f.json { render :show, status: :created, location: @tag}
      else
        f.html { render :new }
        f.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |f|
      if @tag.update(tag_params)
        f.html { redirect_to @tag, notice: 'Tag has succesfully updated' }
        f.json { render :show, status: :ok, location: @tag}
      else
        f.html { render :edit }
        f.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |f|
      f.html { redirect_to tags_url, notice:'Tag was successfully deleted' }
      f.json { head :no_content }
    end
  end

  private

    def set_tag
      @tag =  Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end
