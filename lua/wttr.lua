-- wttr.vim
-- A Vim plugin that displays data from 'http://wttr.in' inside the editor
-- Author: Christian Haudum <christian@haudum.dev>
--

local api = vim.api
local strf = string.format

local function fetch(location)
  local loc = location or "London"
  local cmd = strf("curl -s 'http://wttr.in/%s?nT'", loc)
  local result = api.nvim_call_function("systemlist", {cmd})
  for k, v in pairs(result) do
    result[k] = "  " .. result[k]
  end
  return result
end

local function open_window(result)
  -- create new emtpy buffer
  local buf = api.nvim_create_buf(false, true)

  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_option(buf, "modifiable", true)
  api.nvim_buf_set_lines(buf, 1, -1, false, result)
  api.nvim_buf_set_option(buf, "modifiable", false)
  api.nvim_buf_set_keymap(buf, "n", "q", "<Ctrl>+w q", {silent = true})

  api.nvim_open_win(buf, true, opts)
end

local function weather(location)
  open_window(fetch(location))
end

return {
  weather = weather
}
