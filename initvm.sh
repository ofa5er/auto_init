#!/bin/bash

# Set up correctly depending on the distribution
if [ -f /etc/redhat-release ]
then
  echo "Redhat"
elif [ -f /etc/SuSE-release ]
then
    echo "SuSE"

elif [ -f /etc/debian_version ]
then
  echo "Debian"
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
  sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove && sudo apt-get  -y autoclean
  sudo apt-get -y install -f screen openssh-server openssh-client terminator vim git nmap google-chrome-stable curl ubuntu-make default-jdk tmux make gcc docker zsh
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  wget https://raw.githubusercontent.com/ofa5er/dotfilles/master/.screenrc && mv .screenrc ~/.screenrc
  wget https://raw.githubusercontent.com/ofa5er/dotfilles/master/.tmux.conf && mv .tmux.conf ~/.tmux.conf
  wget https://raw.githubusercontent.com/ofa5er/dotfilles/master/.zshrc && mv .zshrc ~/.zshrc
  echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc
  git config --global core.editor "vim"
  git config --global user.name "Fakher Oueslati"
  git config --global user.email oueslati.fakher@gmail.com
  git config --global credential.helper 'cache --timeout=360000'
  # Make zsh default
  sudo chsh -s $(which zsh)
  # Run docker without sudo
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  newgrp docker
  # Install Docker Compose
  sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.19.0/docker-compose-$(uname -s)-$(uname -m)"
  sudo chmod +x /usr/local/bin/docker-compose 
  docker-compose -v 
  
  
  umake ide visual-studio-code
else
  echo "Other distribution"
fi
