:imap <EXIT_INSERT_MODE> <Esc>
:%s/@posts = Post.all/@posts = Post.order('created_at').page(params[:page]).per(5) # @posts = Post.all/
:wq
