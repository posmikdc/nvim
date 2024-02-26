# My NeoVim Config

## Helpful Learning Resources

Thanks to [Neovim for Newbs by typecraft](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn), I created a rock solid foundation for my NeoVim config. My config is a fork of this one with certain modifications and additions. 

## Structure 

My config is located at `~/config/nvim`. The `init.lua` file "outsources" the plugins and options into the `lua` path. 

- `lua/plugins`: Each plugin (i.e. `telescope.lua`) or plugin family (e.g., `debugging.lua`) is set up in a separate .lua file
- `lua/vim-options:` Set up global options

The package manager, Lazy, is included in the `init.lua` file. Keybindings are defined in the individual `lua/plugin/<name>` files. 

## Core Plugins 

### Overview 
Plugins are managed via Lazy and are outsourced to the `lua/plugins` folder. Each package has a corresponding `<package-name>.lua` file under `~/config/nvim/lua/plugins`. When loading your packages, Lazy will concatenate the package files under `plugins` and load it as one Lua table. Thus, separating your packages into different files just adds extra organization and structure.

Amongst the plugins that are currently installed, there are a handful that are especially important. The ones I will mention in this subsection are the ones that came in the forked config from typecraft. 
- `alpha.lua`: Add a beautiful splash page for NeoVim
- `colorscheme.lua`: Add your color scheme
- `completions.lua`: Set up autocompletions for NeoVim
- `debugging.lua`: Set up debugging
- `git-stuff.lua`: Set up Git workflow
- `lsp-config.lua`: Set up language servers
- `lualine.lua`: Set up a status bar at the bottom of page
- `neo-tree.lua`: Add file tree
- `none-ls.lua`: LSP diagnostics and code actions
- `telescope.lua`: Fuzzy file finder
- `treesitter.lua`: Syntax highlighter and code structure 

### How to add a new plugin?
Very simple! Just go to  `~/config/nvim/lua/plugins`, add the `<package-name>.lua` file. Please note that plugins are written following a certain structure. For detailed information, see the `Plugin Spec` section on the [lazy.nvim](https://github.com/folke/lazy.nvim?tab=readme-ov-file#-plugin-spec) page. Here is an example: 

```{lua}
-- Example for neo-tree.nvim
{
  "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup()
    end,
}
```

### A Note on LSPs 

LSPs (Language Server Protocols) allow for communication between text editors and language servers on your machine. In our case, we use `mason` which enables us to manage and install LSPs in our setup. Now, obviously it is important to not only make sure that your LSPs are correctly set up in your Neovim setup, but also verify that you have installed the actual language servers on your machine. 

## My Plugins 

This is where it gets interesting. In the following section, I will elaborate on the plugins I have added to the typecraft config, what they do, and why I added them. 

### LaTeX Workflow

I use `vimtex.lua` to manage my LaTeX workflow. Since I operate on MacOS, I have opted to use [Skim](https://skim-app.sourceforge.io) as my pdf compiler (Make sure you have it installed locally). It offers easy integration and allows for neat tools like forward search (quickly locate a LaTeX chunk on the compiled pdf version). 

`vimtex.lua` is easy to use. You first activate the compiler (My keybinding: `<localleader>ll`) and then your pdf should pop up. On each save, `:w`, the pdf will recompile. 

### Data Science Workflow

This was the most challenging component of my workflow to translate into NeoVim. I am a heavy R user and I love how easy it is to work with `.Rmd` documents using RStudio in real time. 

I have opted for `quarto-nvim`. [Quarto](https://quarto.org/docs/get-started/) is developed by Posit (Make sure you have it installed locally), the same folks behind RStudio, as a more powerful, flexible, and general purpose version of a `.Rmd` document. Think about it this way: In a Quarto Markdown document (File extension: `.qmd`), you can include chunks of R code, Python code, and Julia code all in the same document. Then, you can compile the `.qmd` document into any type of file you want, e.g., .pdf, .tex, and even .docx. Although I was initially concerned that `.qmd` is a seldom used file format, I now recognize that I rarely share the raw documents externally anyway. In short: Nobody but you will likely even deal with the raw `.qmd` document and only see the compiled output you can easily produce with Quarto. 

I think of `.qmd` as a flexible, language-agnostic supercharged markdown. Similar to my LaTeX workflow, I have set it up such that my `qmd` documents compile in a browser every time I save the document (`:w`). I love that I don't need multiple plugins to deal with the different language I work in, but rather can channel my entire workflow through Quarto. 

A very [helpful YouTube series](https://www.youtube.com/watch?v=3sj7clNowlA) on the use of Quarto in NeoVim helped me tremendously. 

### Coding Workflow and Slime 

In the same spirit as above, I was looking for one plugin that can manage all my coding needs. I opted for `vim-slime`, a plugin that allows you to select any code and send it to a live REPL. 

My coding workflow is different from my data science workflow in that I may not always want to compile a full report but just quickly run a few lines of code. 



