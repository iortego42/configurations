return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  "marko-cerovac/material.nvim",
  "sainnhe/sonokai",
  "sainnhe/everforest",
  "KabbAmine/yowish.vim",
  "trapd00r/neverland-vim-theme",
  "AdnanHodzic/vim-hue",
  "/folke/tokyonight.nvim",
  "dracula/vim",
  "projekt0n/github-nvim-theme",
  "audibleblink/hackthebox.vim",
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    setup = function()
      require("transparent").setup({
        enable = true,
        transparency_amount = 150, -- Adjust the transparency level as needed
      })
    end
  },
  -- {
  --   "xiyaowong/transparent.nvim",
  --   require("transparent").setup({
  --     enable = true,
  --   })
  -- },
  "42Paris/42header",
  "shaunsingh/nord.nvim",
}
