return {
  {
    "folke/snacks.nvim",
    opts = {
      -- Disabled because WezTerm lacks placeholder support, so no inline images
      -- in buffers; only float previews would work, and those need ImageMagick.
      image = { enabled = false },
      -- Only enable where the lazygit binary is installed.
      lazygit = { enabled = vim.fn.executable("lazygit") == 1 },
    },
  },
}
