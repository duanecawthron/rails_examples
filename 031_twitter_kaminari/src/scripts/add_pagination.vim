:imap <EXIT_INSERT_MODE> <Esc>
/<\/table>
A
<br />
<%= paginate @posts %>
<p>Count = <%= @count %></p>
<p>Total Count = <%= @total_count %></p>

<p>Num Pages = <%= @num_pages %></p>
<p>Current Page = <%= @current_page %></p>
<p>First Page = <%= @first_page %></p>
<p>Last Page = <%= @last_page %></p>

<p>Limit Value = <%= @limit_value %></p>
<p>Offset Value = <%= @offset_value %></p>

<EXIT_INSERT_MODE>
:wq
