return {
	"neovim/nvim-lspconfig",
	
	config = function()
		-- Set up lsp installer
		require("mason").setup()

		-- Set up lspconfig.
		local lsp = require("lspconfig")
		--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        
        local telescope = require('telescope.builtin')

		-- Mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '<C-l>', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '<space>d,', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', '<space>d.', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<space>dn', vim.diagnostic.setloclist, opts)

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', '<C-j>', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', '<space>du', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<space>dh', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', '<space>dy', function() vim.lsp.buf.format({ async = true }) end, bufopts)

            -- Telescope LSP
            vim.keymap.set('n', '<space>fu', telescope.lsp_references, bufopts)
            vim.keymap.set('n', '<space>fi', telescope.lsp_implementations, bufopts)
            vim.keymap.set('n', '<space>fo', telescope.lsp_definitions, bufopts)
            vim.keymap.set('n', '<space>fp', telescope.lsp_type_definitions, bufopts)
            vim.keymap.set('n', '<space>fl', telescope.diagnostics, bufopts)
		end

		local lsp_flags = {
			-- This is the default in Nvim 0.7+
			debounce_text_changes = 150,
		}

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lsp.pyright.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.julials.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.texlab.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.gopls.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.rust_analyzer.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.intelephense.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
            settings = {
                intelephense = {
                    environment = {
                        phpVersion = "8.3.0",
                    },
                    format = {
                        braces = "k&r",
                    },
                },
            },
		}
		lsp.clangd.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.tsserver.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
			filetypes = { "javascript", "typescript", "html", "php" }
		}
		lsp.html.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
			filetypes = { "html", "php" }
		}
		lsp.zls.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.cssls.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities
		}
		lsp.htmx.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
			filetypes = { "html", "php" }
		}
        lsp.ltex.setup {
			on_attach = on_attach,
			flags = lsp_flags,
			capabilities = capabilities,
            filetypes = { "markdown", "tex", "bib", "pandoc" }
        }
	end
}
