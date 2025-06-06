return {

  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      llama3 = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "llama3", -- optional, custom adapter name
          schema = {
            model = {
              default = "llama3.1:8b", -- or llama3:latest
            },
            num_ctx = {
              default = 4096,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "llama3" },
      inline = { adapter = "llama3" },
      agent = { adapter = "llama3" },
    },
  },
  keys = {
    {
      "<leader>lc", -- CodeCompanion Chat
      "<cmd>CodeCompanionChat<cr>",
      desc = "Open CodeCompanion Chat",
    },
    {
      "<leader>la", -- CodeCompanion Inline Action (transform, fix, etc)
      "<cmd>CodeCompanion<cr>",
      desc = "Run CodeCompanion Action",
    },
    {
      "<leader>lx", -- Action Palette
      "<cmd>CodeCompanionActions<cr>",
      desc = "Open CodeCompanion Action Palette",
    },
    {
      "<leader>lt", -- Toggle assistant panel (if enabled)
      "<cmd>CodeCompanionToggle<cr>",
      desc = "Toggle CodeCompanion UI",
    },
  },
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
    "echasnovski/mini.diff",
  },
}
