return {
  {
    "luukvbaal/nnn.nvim",
    opts = {
      picker = {
        cmd = "nnn -Pp",
        style = {
          width = 0.9, -- percentage relative to terminal size when < 1, absolute otherwise
          height = 0.8, -- ^
          xoffset = 0.5, -- ^
          yoffset = 0.5, --^
          border = "rounded",
        },
        offset = true,
      },
    },
  },
}
