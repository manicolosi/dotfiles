local map = vim.keymap.set

-- System clipboard via the * register (consistent with muscle memory like
-- "*y in visual mode; aliased to + on macOS).
map({ "n", "x" }, "<leader>y", '"*y')
map("n",          "<leader>Y", '"*Y')
map({ "n", "x" }, "<leader>d", '"*d')
map("n",          "<leader>D", '"*D')
map({ "n", "x" }, "<leader>p", '"*p')
map("n",          "<leader>P", '"*P')

-- Visual paste keeps the original register contents (paste, then re-yank).
map("x", "p", "pgvy", { remap = false })

-- Single-line mouse-wheel scroll in normal/visual/insert.
map({ "n", "v" }, "<ScrollWheelUp>",   "<C-Y>")
map({ "n", "v" }, "<ScrollWheelDown>", "<C-E>")
map("i",          "<ScrollWheelUp>",   "<C-O><C-Y>")
map("i",          "<ScrollWheelDown>", "<C-O><C-E>")

-- Copy current file path (relative) to the system clipboard.
local function copy_to_clipboard(text)
  vim.fn.setreg("*", text)
  vim.notify("Copied: " .. text)
end

map("n", "gyp", function()
  copy_to_clipboard(vim.fn.expand("%:."))
end, { desc = "Copy relative file path" })

map("n", "gyl", function()
  copy_to_clipboard(vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))
end, { desc = "Copy relative file path with line number" })

map("x", "gyl", function()
  local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
  local s, e = math.min(l1, l2), math.max(l1, l2)
  local path = vim.fn.expand("%:.")
  copy_to_clipboard(s == e and (path .. ":" .. s) or (path .. ":" .. s .. "-" .. e))
end, { desc = "Copy relative file path with line range" })
