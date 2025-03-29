return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ▄▄▄ ▗▞▀▘▐▌    ▄▄▄ ▐▌▄   ▄ █ █ ▄▄▄▄  
█    ▝▚▄▖▐▌   █    ▐▌█ ▄ █ █ █ █ █ █ 
█        ▐▛▀▚▖█ ▗▞▀▜▌█▄█▄█ █ █ █   █ 
         ▐▌ ▐▌  ▝▚▄▟▌      █ █       
        ]],
      },
      sections = {
        {
          section = "header",
        },
        { section = "keys", gap = 1 },
      },
    },
  },
}
