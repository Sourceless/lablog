class PostsController < ApplicationController
  http_basic_authenticate_with  :name => ENV['USERNAME'], :password => ENV['PASSWORD'], :except => :show

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    if params[:id] == nil
      @post = Post.last
    else
      @post = Post.find(params[:id])
    end

    @nextpost = Post.find_by_id(@post.id + 1)
    @prevpost = Post.find_by_id(@post.id - 1)

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)

    @post = Post.new(params[:post])
    @post.rendered_content = markdown.render(@post.content)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    @post = Post.find(params[:id])
    params[:post][:rendered_content] = markdown.render(params[:post][:content])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
