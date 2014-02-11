## install direnv: http://direnv.net/2014/02/06/direnv-2.3.0.html
# wget http://zimbatm.s3.amazonaws.com/direnv/direnv2.3.0.linux-amd64
# mv direnv2.3.0.linux-amd64 direnv && chmod +x direnv
# sudo mv direnv /usr/local/bin/

package 'wget' do
  action :install
end

bash 'install direnv' do
  cwd '/tmp'
  code <<-EOH
  wget http://zimbatm.s3.amazonaws.com/direnv/direnv2.3.0.linux-amd64
  mv direnv2.3.0.linux-amd64 direnv
  chmod +x direnv
  mv direnv /usr/local/bin/
  EOH

  not_if 'test -e /usr/local/bin/direnv'
end
