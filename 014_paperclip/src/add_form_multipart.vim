:imap <EXIT_INSERT_MODE> <Esc>
:%s/form_for(@post)/form_for(@post, :html => { :multipart => true })/g 
:wq
