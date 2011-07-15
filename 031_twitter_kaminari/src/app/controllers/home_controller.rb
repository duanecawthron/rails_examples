class HomeController < ApplicationController

  def index
    @per_page = 5

    @total_count = Post.page(nil).total_count();
    num_pages = Post.page(nil).per(@per_page).num_pages();
    if (params[:page] == nil)
      @page_number = num_pages
    else
      @page_number = params[:page]
    end
    # what if new posts are added after we get total_count and before we get posts?
    @posts = Post.order('created_at').page(@page_number).per(@per_page).skip(params[:skip])
    @posts = @posts.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.js # index.js.erb
    end
  end

  def create
    @post = Post.new(:content => params[:content])

    respond_to do |format|
      if @post.save
        format.html { redirect_to :root }  # :root, :back, :home_index
        format.js # create.js.erb
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to :root }
      end
    end
  end

  def count
    @total_count = Post.page(nil).total_count();

    respond_to do |format|
      format.js # count.js.erb
    end
  end

  def more
    @total_count = Post.page(nil).total_count();
    @posts = Post.order('created_at').page(params[:page]).per(params[:per_page]).skip(params[:skip])
    @posts = @posts.reverse

    respond_to do |format|
      format.js # index.js.erb
    end
  end

end

