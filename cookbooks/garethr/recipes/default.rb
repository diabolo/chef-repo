%w{zsh wget curl lynx git-core ack-grep vim-nox}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/vagrant/.oh-my-zsh" do
  repository node[:garethr][:ohmyzsh]
  action :checkout
  user "vagrant"
  group "vagrant"
end

execute ".zshrc" do
  command "cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc"
  creates "/home/vagrant/.zshrc"
  user "vagrant"
end

execute "usermod -s /bin/zsh vagrant"

git "/home/vagrant/.vim" do
  repository node[:garethr][:dotvim]
  action :checkout
  user "vagrant"
end

execute "compile command-t extension for vim" do
  command "cd /home/vagrant/.vim/ruby/command-t; ruby extconf.rb; make clean; make"
  user "vagrant"
end

link "/home/vagrant/.vimrc" do
  to "/home/vagrant/.vim/vimrc"
  owner "vagrant"
end
