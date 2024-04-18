return {
  "lervag/vimtex",
  init = function()
    -- Config: https://dr563105.github.io/blog/skim-vimtex-setup/
    vim.g.tex_flavor = 'latex' -- Default tex file format
    vim.g.vimtex_view_method = 'skim' -- Choose which program to use to view PDF file
    vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
    -- Set up compiler engines
    vim.g.vimtex_compiler_latexmk_engines = {
      ['_'] = '-lualatex', -- Set default '_' to lualatex as the typesetting engine
    }
    -- Automatically clean up auxiliary files when last buffer for a project is quit 
    -- https://github.com/lervag/vimtex/issues/253
    local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventQuit",
      group = au_group,
      command = "VimtexClean",
    })

    -- Custom which-key descriptions
    local wk = require("which-key")
    wk.register({
      ["<localleader>l"] = {"VimTex"},
      ["<localleader>ll"] = {"Begin Compiler"},
      ["<localleader>lv"] = {"View"},
    })
  end,
}

