class HomeController < ApplicationController
  def index
    @posts = Post.all(:order => "created_at DESC")
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.create(:content => params[:content])
    respond_to do |format|
      if @post.save
        format.html { redirect_to :root }  # :root, :back, :home_index
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to :root }
      end
    end
  end
end
