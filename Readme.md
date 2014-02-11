## Direnv Cookbook


## Usage

    include_recipe 'direnv'

    direnv_hook 'root' do
      shell 'bash'
    end

    direnv_hook 'vagrant' do
      shell 'bash'
    end
