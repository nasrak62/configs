return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    providers = {
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        extra_request_body = {
          temperature = 0,
          max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        },
      },

      llama = {
        endpoint = "http://127.0.0.1:11434",
        model = "llama3.1:8b",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. "/api/chat",
            headers = {
              ["Content-Type"] = "application/json",
            },
            body = {
              model = opts.model,
              messages = require("avante.providers").copilot.parse_messages(opts, code_opts),
              stream = true,
              options = {
                tools = code_opts.tools, -- if tools are used
              },
            },
          }
        end,
        parse_stream_data = function(data, handler_opts)
          local json_data = vim.fn.json_decode(data)
          if json_data and json_data.done then
            handler_opts.on_complete(nil)
            return
          end
          if json_data and json_data.message and json_data.message.content then
            handler_opts.on_chunk(json_data.message.content)
          end
        end,
      },
      codellama = {
        endpoint = "http://127.0.0.1:11434",
        model = "codellama:13b",
        disable_tools = true,
      },
      deepseek = {
        endpoint = "http://127.0.0.1:11434",
        model = "deepseek-coder:14b",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  keys = {
    {
      "<leader>lls",
      function()
        local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if git_root and vim.fn.isdirectory(git_root) == 1 then
          vim.cmd("cd " .. git_root)
          print("Changed working directory to Git root: " .. git_root)
        else
          vim.cmd("cd %:p:h")
          print("Changed working directory to current file's directory: " .. vim.fn.expand("%:p:h"))
        end
      end,
      desc = "Sync working directory to Git root or current file",
    },
    {
      "<leader>ll1",
      function()
        require("avante.api").switch_provider("openai")
      end,
      desc = "Switch to OpenAI",
    },
    {
      "<leader>ll2",
      function()
        require("avante.api").switch_provider("llama")
      end,
      desc = "Switch to Llama",
    },
    {
      "<leader>ll3",
      function()
        require("avante.api").switch_provider("deepseek")
      end,
      desc = "Switch to DeepSeek",
    },
  },
}
