:imap <EXIT_INSERT_MODE> <Esc>
/def per
/end
/end
A

def skip(num)
  if (n = num.to_i) <= 0
    self
  else
    limit(limit_value).offset(offset_value + n)
  end
end

<EXIT_INSERT_MODE>
:wq
