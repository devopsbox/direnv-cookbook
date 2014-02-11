## http://www.slideshare.net/geekbri/lwrp-presentation
action :install do
  if Patcher.was_patched?(@new_resource)
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Creating Direnv Hook #{ @new_resource }") do
      Patcher.patch_shell_config(@new_resource.user, @new_resource.shell)
    end
  end
end


class Patcher
  CHEF_START_MARKER = '## -- CHEF-GENERATED-START -- ##'
  CHEF_END_MARKER = '## -- CHEF-GENERATED-END -- ##'
  def self.patch_shell_config(user, shell)
    patch          = hook_text(shell)
    current_config = ::File.read(config_name(user, shell))
    return if current_config.include?(hook_text(shell))
    ::File.write(config_name(user, shell), current_config + patch)
  end

  def self.hook_text(shell)
    hook_text = `direnv hook #{shell}`.strip
    ['', CHEF_START_MARKER, hook_text, CHEF_END_MARKER, ''].join("\n")
  end

  def self.was_patched?(new_resource)
    user  = new_resource.user
    shell = new_resource.shell

    current_config = ::File.read(config_name(user, shell))
    current_config.include?(hook_text(shell))
  end

  def self.config_name(user, shell)
    home = (user == 'root') ? '/root' : "/home/#{user}"
    shell_config = (shell == 'bash') ? '.bashrc' : '.zshrc'
    ::File.join(home, shell_config)
  end
end
