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
  sudo apt-get -y install -f screen openssh-server openssh-client terminator vim git nmap google-chrome-stable curl ubuntu-make default-jdk
  wget https://github.com/ofa5er/dotfiles/blob/master/.screenrc -o ~/.screenrc
  echo "autocmd Filetype gitcommit setlocal spell textwidth=72" >> ~/.vimrc
  git config --global core.editor "vim"
  git config --global user.name "Fakher Oueslati"
  git config --global user.email oueslati.fakher@gmail.com
  umake ide visual-studio-code
else
  echo "Other distribution"
fi
