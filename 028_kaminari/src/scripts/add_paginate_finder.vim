:imap <EXIT_INSERT_MODE> <Esc>
:%s/@posts = Post.all/@posts = Post.order('created_at').page(params[:page]).per(5) # @posts = Post.all/
:1
/def index
A
@count = Post.page().count();
@total_count = Post.page().total_count();

@num_pages = Post.page().per(5).num_pages();
@current_page = Post.page(params[:page]).per(5).current_page();
@first_page = Post.page(params[:page]).per(5).first_page?();
@last_page = Post.page(params[:page]).per(5).last_page?();

@limit_value = Post.page(params[:page]).per(5).limit_value();
@offset_value = Post.page(params[:page]).per(5).offset_value();

<EXIT_INSERT_MODE>
:wq
