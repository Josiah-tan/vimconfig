
require'nvim-treesitter.configs'.setup {
	ensure_installed = {'python', 'lua', 'latex', 'vim', 'c', 'cpp'}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ignore_install = {}, -- List of parsers to ignore installing
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = {"latex"},  -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = false -- for some reason this messes up C indentation
	},
}

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.markdown = {
--   install_info = {
--     url = "~/Desktop/josiah/neovim/tree-sitter-markdown", -- local path or git repo
--     files = {"src/parser.c"},
--     -- optional entries:
--     branch = "main", -- default branch in case of git repo if different from master
--     generate_requires_npm = true, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "md", -- if filetype does not agrees with parser name
--   -- used_by = {"bar", "baz"} -- additional filetypes that use this parser
-- }

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim 
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sl"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sh"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
