#!/bin/bash

# Set up correctly depending on the distribution
if [ -f /etc/redhat-release ]; then
  echo "Redhat"
elif [ -f /etc/SuSE-release ]; then
    echo "SuSE"
elif [ -f /etc/debian_version ]; then
  dist=`grep ^ID= /etc/os-release | awk -F '=' '{print $2}'`
  if [ "$dist" == "ubuntu" ]; then
    # Ubuntu 16LTS
    echo "Ubuntu"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
    sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove && sudo apt-get  -y autoclean
    sudo apt-get -y install -f screen openssh-server openssh-client terminator vim git nmap google-chrome-stable curl ubuntu-make default-jdk tmux make gcc zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.screenrc && mv .screenrc ~/.screenrc
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.tmux.conf && mv .tmux.conf ~/.tmux.conf
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.zshrc && mv .zshrc ~/.zshrc
    echo "syntax on" >> ~/.vimrc
    echo "filetype plugin indent on" >> ~/.vimrc
    echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc
    # Make zsh default
    sudo chsh -s $(which zsh)
    # Install Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update 
    apt-cache policy docker-ce 
    sudo apt-get install -y docker-ce 
    sudo systemctl status docker 
    #Execute with Sudo (Optional) 
    sudo usermod -aG docker ${USER} 
    su - ${USER} 
    id -nG
    # Install Docker Compose
    sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.19.0/docker-compose-$(uname -s)-$(uname -m)"
    sudo chmod +x /usr/local/bin/docker-compose 
    docker-compose -v 


    umake ide visual-studio-code
  elif [ "$dist" == "debian" ]; then
    #Debian Jessie --- Borken for now
    echo "Debian"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove && sudo apt-get  -y autoclean
    sudo apt-get -y install -f screen openssh-server openssh-client terminator vim git nmap google-chrome-stable curl tmux make gcc zsh build-essential module-assistant code
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.screenrc && mv .screenrc ~/.screenrc
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.tmux.conf && mv .tmux.conf ~/.tmux.conf
    wget https://raw.githubusercontent.com/ofa5er/dotfiles/master/.zshrc && mv .zshrc ~/.zshrc
    echo "syntax on" >> ~/.vimrc
    echo "filetype plugin indent on" >> ~/.vimrc
    echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc
    # Make zsh default
    chsh -s $(which zsh)
    # Install Visual Code
    wget https://go.microsoft.com/fwlink/?LinkID=760868
    sudo dpkg -i code*
    sudo apt-get install -f
    
    sudo m-a m-a prepare
  else
    echo "Debian Other"
  fi


else
  echo "Other distribution"
fi

## Common
# Git config
git config --global core.editor "vim"
git config --global user.name "Fakher Oueslati"
git config --global user.email CHANGE_WITH_MY_EMAIL
git config --global credential.helper 'cache --timeout=36000'
git config --global push.default simple
git config --global pull.rebase true
