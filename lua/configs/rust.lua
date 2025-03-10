local M = {}

M.setup = function()
  local bufnr = vim.api.nvim_get_current_buf()

  vim.keymap.set("n", "<leader>a", function()
    vim.cmd.RustLsp("codeAction") -- Группировка codeAction rust-analyzer
  end, { silent = true, buffer = bufnr })

  vim.keymap.set("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" }) -- RustLsp hover actions
  end, { silent = true, buffer = bufnr })
end

return M
