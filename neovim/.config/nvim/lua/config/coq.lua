local M = {}

function M.setup()
  local coq = require('coq')
  coq.Now()

  require('coq_3p'){
    { src = 'nvimlua', short_name = 'nLUA', conf_only = false }, -- Lua
    {
      src = 'repl',
      sh = 'zsh',
      shell = { p = 'perl', n = 'node' },
      max_lines = 99,
      deadline = 500,
      unsafe = { 'rm', 'poweroff', 'mv' },
    },
  }
end

return M
