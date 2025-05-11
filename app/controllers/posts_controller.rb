class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  # layout "dashboard", only: [ :index ]
  # layout :determine_layout

  def index
    @posts = Post.all
    @posts = filter_by_title(@posts, params[:title])
    @posts = filter_by_user(@posts, params[:user_id])
    @posts = filter_by_date(@posts, params[:published_after])

    @posts = sort_posts(@posts, params[:sort])

    @posts = @posts.page(params[:page]).per(2)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "게시물이 성공적으로 생성되었습니다" }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity  }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "게시물이 수정되었습니다" # posts/:id
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "게시물이 삭제되었습니다"
  end

  private

  def determine_layout
    action_name == "index" ? "dashboard" : "application"
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user_id == session[:user_id]
      redirect_to posts_path
    end
  end

  def filter_by_title(posts, title)
    title.present? ? posts.where("title LIKE ?", "%#{title}%") : posts
  end

  def filter_by_user(posts, user_id)
    user_id.present? ? posts.where(user_id: user_id) : posts
  end

  def filter_by_date(posts, date)
    date.present? ? posts.where("published_at >= ?", date) : posts
  end

  def sort_posts(posts, sort_param)
    posts.order(sort_param || "created_at DESC")
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :body, :published, :published_at)
  end
end
