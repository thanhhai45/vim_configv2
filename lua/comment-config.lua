local status_ok, comment = pcall(require, "nvim_comment")
if not status_ok then
  return
end

comment.setup {
  hook = function()
    if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
    if vim.api.nvim_buf_get_option(0, "filetype") == "tsx" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
    if vim.api.nvim_buf_get_option(0, "filetype") == "ts" then
      require("ts_context_commentstring.internal").update_commentstring()
    end
  end
}

