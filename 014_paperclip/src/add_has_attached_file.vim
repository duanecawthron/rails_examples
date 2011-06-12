:imap <EXIT_INSERT_MODE> <Esc>
?end
i  has_attached_file :avatar

# The next 3 lines are optional.
validates_attachment_presence :avatar                    
validates_attachment_size :avatar, :less_than=>10.megabyte
validates_attachment_content_type :avatar, :content_type=>['image/jpeg', 'image/png', 'image/gif']

<EXIT_INSERT_MODE>
:wq
