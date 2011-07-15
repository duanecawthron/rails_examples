:imap <EXIT_INSERT_MODE> <Esc>
:%s/@posts = Post.all/@posts = Post.order('created_at').page(params[:page]).per(5).skip(params[:skip]) # @posts = Post.all/
:1
/def index
A
@count = Post.page(nil).count();
@total_count = Post.page(nil).total_count();

@num_pages = Post.page(nil).per(5).num_pages();
@current_page = Post.page(params[:page]).per(5).current_page();
@first_page = Post.page(params[:page]).per(5).first_page?();
@last_page = Post.page(params[:page]).per(5).last_page?();

@limit_value = Post.page(params[:page]).per(5).limit_value();
@offset_value = Post.page(params[:page]).per(5).offset_value();

<EXIT_INSERT_MODE>
:wq
