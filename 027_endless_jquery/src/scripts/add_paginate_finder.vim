:imap <EXIT_INSERT_MODE> <Esc>
:%s/@posts = Post.all/@posts = Post.paginate :page => params[:page], :per_page => 5, :order => 'updated_at DESC' # @posts = Post.all/
:wq
