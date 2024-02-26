return {
  "lervag/vimtex",
  init = function()
    -- Config: https://dr563105.github.io/blog/skim-vimtex-setup/
    vim.g.tex_flavor = 'latex' -- Default tex file format
    vim.g.vimtex_view_method = 'skim' -- Choose which program to use to view PDF file
    vim.g.vimtex_view_skim_sync = 1 -- Value 1 allows forward search after every successful compilation
    vim.g.vimtex_view_skim_activate = 1 -- Value 1 allows change focus to skim after command `:VimtexView` is given
    
    -- Keymaps 
		vim.keymap.set("n", "<localleader>ll", ":VimtexCompile<CR>")
    vim.keymap.set("n", "<localleader>lv", ":VimtexView<CR>")
    
    -- Custom which-key descriptions
    local wk = require("which-key")
      wk.register({
        ["<localleader>l"] = {"VimTex"},
        ["<localleader>ll"] = {"Begin Compiler"},
        ["<localleader>lv"] = {"View"},
      })
  end,
}
