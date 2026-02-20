return {
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = { enabled = true },
    },
    keys = {
      {
        "<leader>gy",
        function()
          Snacks.gitbrowse.open({
            open = function(url)
              vim.fn.setreg("+", url)
              vim.notify("Copied URL")
            end,
          })
        end,
        desc = "Copy repo link (line/selection)",
        mode = { "n", "v" },
      },
    },
  },
}
