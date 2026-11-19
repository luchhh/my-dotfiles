-- tree-sitter parser names (what gets installed)
local ensure_installed = {
  "lua", "vim", "vimdoc", "query",
  "bash", "markdown", "markdown_inline",
  "json", "yaml", "toml",
  "python", "rust", "go",
  "javascript", "typescript", "tsx", "html", "css",
}

-- corresponding vim filetypes (what the FileType autocmd matches on) —
-- not 1:1 with parser names, and markdown_inline has no filetype of its
-- own since it's auto-injected into markdown buffers
local filetypes = {
  "lua", "vim", "help", "query",
  "sh", "markdown",
  "json", "yaml", "toml",
  "python", "rust", "go",
  "javascript", "typescript", "typescriptreact", "html", "css",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false, -- main branch explicitly doesn't support lazy-loading
  config = function()
    require("nvim-treesitter").install(ensure_installed)

    -- highlighting/indentation are opt-in per filetype on this plugin's
    -- rewritten `main` branch; enable them for every buffer that gets a
    -- parser installed above
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        -- install() above is async; on a parser's very first install this
        -- can fire before the download/compile finishes, so don't hard-fail
        if pcall(vim.treesitter.start) then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
