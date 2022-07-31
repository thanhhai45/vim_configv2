require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tomasr/molokai'
  use { 
    'vimwiki/vimwiki',
    config = function()
      g.vimwiki_list = {
        {
          path = '~/devenv/codevion.github.io/',
          syntax = 'markdown',
          ext = '.md',
        }
      }

      g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
        ['.markdown'] = 'markdown',
        ['.mdown'] = 'markdown',
      }
    end
  }
end)
