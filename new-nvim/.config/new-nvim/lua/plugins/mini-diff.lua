return { 
  'echasnovski/mini.diff', 
  version = false, 
  opts = {
    view = {
      style = 'sign'
    }
  },
  config = function (opts)
    require('mini.diff').setup({
      view = {
        style = 'sign'
      }
    })
  end
}

